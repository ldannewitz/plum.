class BillSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :user_id, :amount, :satisfied?

  belongs_to :event
  belongs_to :user
end
