class BillSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :user_id, :bill_type, :amount, :satisfied?

  belongs_to :event
  belongs_to :user
end
