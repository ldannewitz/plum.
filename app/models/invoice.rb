class Invoice < ActiveRecord::Base
  belongs_to :event
  belongs_to :group, through: :event
  belongs_to :user

  validates :event_id, :user_id, :invoice_type, :amount, :satisfied?, presence: true
end
