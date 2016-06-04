class Invoice < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event_id, :user_id, :invoice_type, :amount, presence: true
end
