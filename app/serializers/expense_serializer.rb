class ExpenseSerializer < ActiveModel::Serializer
  attributes :id, :event_id, :spender_id, :description, :amount, :location

  belongs_to :event
  belongs_to :member
end
