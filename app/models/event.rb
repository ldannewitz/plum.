require 'paypal-sdk-rest'
require 'paypal-sdk-invoice'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging
require 'sendgrid-ruby'
require 'send_grid.rb'

class Event < ApplicationRecord
  include SendGrid
  belongs_to :group
  has_many :memberships, through: :group
  has_many :members, through: :memberships, class_name: 'User'
  has_many :expenses
  has_many :bills

  validates :name, :start_date, :end_date, :group_id, :total, presence: true

  # is the event over? If so, generate_invoices
  def expired?
    # puts self.end_date
    # puts Time.now
    # puts self.end_date < Time.now
    self.end_date < DateTime.now ? generate_invoices : false
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
      # p bill
      # Get user
      user = User.find_by(email: bill[0])
      # Get bill type
      bill_type = nil
      if bill[1] == 0
        return 0
      elsif bill[1] > 0
        bill_type = 'credit'
      elsif bill[1] < 0
        bill_type = 'debit'
      end

      # create bill object
      @new_bill = Bill.create!(event_id: self.id, user_id: user.id, bill_type: bill_type, amount: bill[1].round(2), satisfied?: false)

      # for the users that owe money, create an invoice using PayPal API
      if bill_type == 'debit'
        name = self.name
        email = User.find(@new_bill.user_id).email
        # p @new_bill.amount
        unit_price = (@new_bill.amount * (-1))

        # Set up PayPal client
        @api = PayPal::SDK::Invoice::API.new(
          :mode      => "sandbox",
          :app_id    => ENV['APP_ID'],
          :username  => ENV['USERNAME'],
          :password  => ENV['PASSWORD'],
          :signature => ENV['SIGNATURE'])
          # :token =>
          # :token_secret => )

        # Build request object
        @create_and_send_invoice = @api.build_create_and_send_invoice({
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
        @create_and_send_invoice_response = @api.create_and_send_invoice(@create_and_send_invoice)

        # Access Response
        if @create_and_send_invoice_response.success?
          @new_bill.update_attribute(:paypal_invoice_id, @create_and_send_invoice_response.invoiceID)
          @new_bill.save
          puts "email in generate invoices"
          puts email
          send_email(@new_bill.paypal_invoice_id, email)
          # p "yes"
          # p @create_and_send_invoice_response
          @create_and_send_invoice_response.invoiceID
          @create_and_send_invoice_response.invoiceNumber
          @create_and_send_invoice_response.invoiceURL
          @create_and_send_invoice_response.totalAmount
        else
          # p "no"
          @create_and_send_invoice_response.error
        end
      end # close API call
    end # close create bill loop
  end # close generate_invoices method

end

# https://www.sandbox.paypal.com/us/cgi_bin/webscr?cmd=_pay-inv&id=INV2-QKQM-JHZT-ABBL-8LUX&viewtype=altview
