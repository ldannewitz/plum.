require 'httparty'
require 'paypal-sdk-rest'
include PayPal::SDK::REST


class Event < ApplicationRecord
  belongs_to :group
  has_many :memberships, through: :group
  has_many :members, through: :memberships, class_name: 'User'
  has_many :expenses
  has_many :invoices

  validates :name, :start_date, :end_date, :group_id, :total, presence: true

  # is the event over? If so, generate_invoices
  def expired?
    self.end_date < Time.now ? generate_invoices : false
  end

  # find how much each member would pay in an even split
  def even_split
    self.total / self.members.count.to_f
  end

  # find how much each group member owes/will be credited & add it to invoice_hash
  def get_member_balances
    invoice_hash = {}
    self.members.each do |member|
      invoice_hash[member.email] = find_member_total(self.expenses, member) - self.even_split
    end
    # return payment amounts in a hash
    invoice_hash
  end

  # find how much each member has already paid
  def find_member_total(expenses, member)
    total = 0
    expenses.each { |expense| total += expense.amount if expense.spender_id == member.id }
    total
  end

  # generate invoice objects in the database
  def g
    # self.get_member_balances.each do |invoice|
    #   # Get user
    #   user = User.find_by(email: invoice[0])
    #   # Get invoice type
    #   invoice_type = nil
    #   if invoice[1] > 0
    #     invoice_type = 'credit'
    #   elsif invoice[1] < 0
    #     invoice_type = 'debit'
    #   end
    #   # create invoice object
    #   invoice = Invoice.create!(event_id: self.id, user_id: user.id, invoice_type: invoice_type, amount: invoice[1], satisfied?: false)

      # body =


    end

    # Access Response
    # if @response.success?
    #   @response.TransactionID
    # else
    #   @response.Errors
    # end
  # end

end
