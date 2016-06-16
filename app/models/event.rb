require 'paypal-sdk-rest'
require 'paypal-sdk-invoice'
include PayPal::SDK::REST
include PayPal::SDK::Core::Logging
require 'sendgrid-ruby'
require 'send_grid.rb'
require 'paypal_module.rb'

class Event < ApplicationRecord
  include SendGrid
  include Paypal
  belongs_to :group
  has_many :memberships, through: :group
  has_many :members, through: :memberships, class_name: 'User'
  has_many :expenses, dependent: :destroy
  has_many :bills, dependent: :destroy

  validates :name, :start_date, :end_date, :group, :total, presence: true

  # is the event over? If so, generate_invoices
  def expired?
    end_date < DateTime.now ? generate_invoices : false
  end

  # find how much each member would pay in an even split
  def even_split
    total / members.count.to_f
  end

  # find how much each group member owes/will be credited & add it to bills_hash
  def get_member_balances
    bills_hash = {}
    members.each do |member|
      bills_hash[member.email] = find_member_total(expenses, member) - even_split
    end
    # return credit/debit amounts in a hash
    bills_hash
  end

  # find how much each member has already paid
  def find_member_total(expenses, member)
    relevant_expenses = expenses.select {|expense| expense.spender_id == member.id }
    relevant_expenses.reduce(0) { |total, expense| total + expense.amount }
  end

  # Check all invoices for an event that are typs "debit"
  # If they have all be satisfied, payout the creditors
  def all_bills_paid?
    if settled? == false
      all_paid = false
      bills.each do |bill|
        if bill.bill_type == 'debit' && bill.satisfied? == false
          return all_paid
        end
      end
      payout
    else
      "This event is settled"
    end
  end

  # Update an event status to satisfied when all debtors and paid and all creditors have been paid
  def settle_event
    bills.each do |bill|
      if bill.satisfied? == false
        return "not satisfied"
      end
    end
    update_attributes(:settled? => true)
  end

  def tentativebalance(member)
    (find_member_total(expenses, member) - even_split).round(2)
  end
end
