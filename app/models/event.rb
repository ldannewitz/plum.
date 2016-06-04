class Event < ApplicationRecord
  belongs_to :group
  has_many :memberships, through: :group
  has_many :members, through: :memberships, class_name: 'User'
  has_many :expenses
  has_many :invoices

  validates :name, :start_date, :end_date, :group_id, :total, presence: true

  def expired?
    # is the event over?
    self.end_date < Time.now ? create_invoices : false
  end

  def even_split
    # find out how much each member would pay in an even split
    self.total/self.members.count.to_f
  end

  def get_member_balances
    invoice_hash = {}
    group_members = self.members

    # find how much each person owes
    group_members.each do |member|
      member_total = find_member_total(self.expenses, member)
      invoice_hash[member.email] = member_total - self.even_split
    end
    # return payment amounts in a hash
    invoice_hash
  end

  def find_member_total(expenses, member)
    total = 0
    expenses.each { |expense| total += expense.amount if expense.spender_id == member.id }
    total
  end

  def generate_invoice_objects
    invoices = self.get_member_balances
    invoices.each do |invoice|
      # Get user
      user = User.find_by(email: invoice[0])
      # Get invoice type
      invoice_type = nil
      if invoice[1] > 0
        invoice_type = 'credit'
      elsif invoice[1] < 0
        invoice_type = 'debit'
      end
      # create invoice object
      Invoice.create!(event_id: self.id, user_id: user.id, invoice_type: invoice_type, amount: invoice[1], satisfied?: false)
    end
  end

end
