class Expense < ActiveRecord::Base
  belongs_to :event
  belongs_to :member, through: :event

  validates :event_id, :spender_id, :description, :amount, presence: true
end
