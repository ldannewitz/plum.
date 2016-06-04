class Invoice < ApplicationRecord
  belongs_to :event
  belongs_to :group
  belongs_to :user

  validates :event_id, :user_id, :invoice_type, :amount, :satisfied?, presence: true
end
