class Expense < ApplicationRecord
  belongs_to :event
  belongs_to :member, class_name: 'User'

  validates :event_id, :spender_id, :description, :amount, presence: true
end
