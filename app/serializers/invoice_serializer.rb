class InvoiceSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :user_id, :invoice_type, :amount, :satisfied?

  belongs_to :event
  belongs_to :user
end
