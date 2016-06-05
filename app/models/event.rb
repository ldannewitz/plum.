require 'paypal-sdk-invoice'
include PayPal::SDK::REST

class Event < ApplicationRecord
  belongs_to :group
  has_many :memberships, through: :group
  has_many :members, through: :memberships, class_name: 'User'
  has_many :expenses
  has_many :bills

  validates :name, :start_date, :end_date, :group_id, :total, presence: true

  # is the event over? If so, generate_bills
  def expired?
    self.end_date < Time.now ? generate_bills : false
  end

  # find how much each member would pay in an even split
  def even_split
    self.total / self.members.count.to_f
  end

  # find how much each group member owes/will be credited & add it to bills_hash
  def get_member_balances
    bills_hash = {}
    self.members.each do |member|
      bills_hash[member.email] = find_member_total(self.expenses, member) - self.even_split
    end
    # return credit/debit amounts in a hash
    bills_hash
  end

  # find how much each member has already paid
  def find_member_total(expenses, member)
    total = 0
    expenses.each { |expense| total += expense.amount if expense.spender_id == member.id }
    total
  end

  # generate bill objects in the database
  def generate_invoices
    self.get_member_balances.each do |bill|
      # Get user
      user = User.find_by(email: bill[0])
      # Get bill type
      bill_type = nil
      if bill[1] > 0
        bill_type = 'credit'
      elsif bill[1] < 0
        bill_type = 'debit'
      end

      # create bill object
      new_bill = Bill.create!(event_id: self.id, user_id: user.id, bill_type: bill_type, amount: bill[1].round(2), satisfied?: false)
      p new_bill

      # for the users that owe money, create an invoice using PayPal API
      if bill_type == 'debit'
        name = self.name
        email = User.find(new_bill.user_id).email
        unit_price = (new_bill.amount * (-100)).round(0).to_s

        # Set up PayPal client
        @api = PayPal::SDK::Invoice::API.new(
          :mode      => "sandbox",
          :app_id    => ENV['APP_ID'],
          :username  => ENV['USERNAME'],
          :password  => ENV['PASSWORD'],
          :signature => ENV['SIGNATURE'] )

        # Build request object
        @create_invoice = @api.build_create_invoice({
          :invoice => {
            :merchantEmail => ENV['MERCHANT_EMAIL'],
            :payerEmail => email,
            :itemList => {
                :item => [{ "name": name,
                            "quantity": "1",
                            "unitPrice": unit_price
                          }]
                          },
            :currencyCode => "USD",
            :paymentTerms => "DueOnReceipt" } })

        # Make API call & get response
        @create_invoice_response = @api.create_invoice(@create_invoice)

        # Response
        if @create_invoice_response.success?
          p "Good"
          p @create_invoice_response.invoiceID
          p @create_invoice_response.invoiceNumber
          p @create_invoice_response.invoiceURL
        else
          p "Bad"
          @create_invoice_response.error
        end
      end # close API call
    end # close create bill loop
  end # close generate_invoices method

end
