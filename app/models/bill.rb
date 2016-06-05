class Bill < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event_id, :user_id, :bill_type, :amount, presence: true
end
