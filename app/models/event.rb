class Event < ApplicationRecord
  belongs_to :group
  has_many :memberships, through: :group
  has_many :members, through: :memberships
  has_many :expenses
  has_many :invoices

  validates :name, :start_date, :end_date, :settled?, :group_id, :total, presence: true
end
