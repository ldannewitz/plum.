class Event < ApplicationRecord
  belongs_to :group
  has_many :memberships, through: :group
  has_many :members, through: :memberships
  has_many :expenses
  has_many :invoices

  validates :name, :start_date, :end_date, :settled?, :group_id, :total, presence: true

  def expired?
    if self.expired?
      create_invoices
    end
  end

  def create_invoices
    group_members = self.members
    even_split = self.total/group_members.length.to_f
    p even_split
    # Create a hash that has user_id(keys), user_expense_total_difference(values)

    # Iterate over hash and create Invoice objects
  end

  def find_member_total

  end

end
