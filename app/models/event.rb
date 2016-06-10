require './app/apis/send_grid.rb'
require './app/apis/invoice_api.rb'

class Event < ApplicationRecord
  include SendGrid
  belongs_to :group
  has_many :memberships, through: :group
  has_many :members, through: :memberships, class_name: 'User'
  has_many :expenses, dependent: :destroy
  has_many :bills, dependent: :destroy

  validates :name, :start_date, :end_date, :group, :total, presence: true

  # is the event over? If so, generate_invoices
  def expired?
    # puts self.end_date
    # puts Time.now
    # puts self.end_date < Time.now
    self.end_date < DateTime.now ? generate_invoices : false
  end

  # find how much each member would pay in an even split
  def even_split
    total / members.count.to_f
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
    relevant_expenses = expenses.select {|expense| expense.spender_id == member.id }
    relevant_expenses.reduce(0) { |total, expense| total + expense.amount }
  end

  # generate bill objects in the database
  def generate_invoices
    self.get_member_balances.each do |bill|
      # Get user
      @user = User.find_by(email: bill[0])
      # Get bill type
      bill_type = nil
      if bill[1] == 0
        # If the user paid exactly their fair share...create a bill for them with amount 0
        return @new_bill = Bill.find_or_create_by(event_id: self.id, user_id: @user.id, bill_type: 'debit', amount: 0.round(2), satisfied?: true)
      elsif bill[1] > 0
        bill_type = 'credit'
      elsif bill[1] < 0
        bill_type = 'debit'
      end

      # create bill object
      @new_bill = Bill.find_by(event_id: self.id, user_id: @user.id, bill_type: bill_type, amount: bill[1].round(2))

      # for the users that owe money, create an invoice using PayPal API
      if @new_bill.nil? # prevent duplicate paypal invoices
        @new_bill = Bill.create(event_id: self.id, user_id: @user.id, bill_type: bill_type, amount: bill[1].round(2))
        if bill_type == 'debit'
          event_name = self.name
          email = @user.email
          unit_price = (@new_bill.amount * (-1))
          invoice_api = InvoiceApi.new

          # Build request object
          invoice = invoice_api.create_invoice(email, event_name, unit_price)

          # Make API call & get response
          invoice_response = invoice_api.send_invoice(invoice)

          # Access Response
          if invoice_response.success?
            @new_bill.update_attribute(:paypal_id, invoice_response.invoiceID)
            @new_bill.save
            send_email(@new_bill.paypal_id, email)
            # p "yes"
            #
            # p invoice_response
            # invoice_response.invoiceID
            # invoice_response.invoiceNumber
            # invoice_response.invoiceURL
            # invoice_response.totalAmount
          else
            invoice_response.error
          end # close response loop
        end # close API call
      end # close duplicate invoice loop
    end # close create bill loop
  end # close generate_invoices method

  # Check all invoices for an event that are typs "debit"
  # If they have all be satisfied, payout the creditors
  def all_bills_paid?
    if self.settled? == false
      all_paid = false
      self.bills.each do |bill|
        if bill.bill_type == 'debit' && bill.satisfied? == false
          return all_paid
        end
      end
      self.payout
    else
      "This event is settled"
    end
  end

  # Payout the creditors
  def payout
    self.bills.each do |bill|
      if bill.bill_type == 'credit' && bill.satisfied? == false
        creditor = User.find(bill.user_id)
        email = creditor.email

        # Set up PayPal client
        PayPal::SDK::REST.set_config(
          :mode => "sandbox",
          :client_id => ENV['CLIENT_ID'],
          :client_secret => ENV['CLIENT_SECRET'])

        # Build request object
        @payout = Payout.new(
            {
              :sender_batch_header => {
                :sender_batch_id => SecureRandom.hex(8),
                :email_subject => 'You have a Payout!',
              },
              :items => [
                {
                  :recipient_type => 'EMAIL',
                  :amount => {
                    :value => bill.amount,
                    :currency => 'USD'
                  },
                  :note => 'Thanks for your patronage!',
                  :receiver => email,
                  :sender_item_id => "2014031401013",
                }]})

        # Create Payment and return the status (true/false)
        if @payout.create
          bill.update_attributes(:satisfied? => true, :paypal_id => "123")
          settle_event
        else
          @payout.error  # Error Hash
        end # Close if/else status
      end # Close if bill.bill_type = 'credit' loop
    end # Close bills.each loop
  end # Close payout method

  # Update an event status to satisfied when all debtors and paid and all creditors have been paid
  def settle_event
    self.bills.each do |bill|
      if bill.satisfied? == false
        return "not satisfied"
      end
    end
    self.update_attributes(:settled? => true)
  end

  def tentativebalance(member)
    (find_member_total(self.expenses, member) - self.even_split).round(2)
  end
end
