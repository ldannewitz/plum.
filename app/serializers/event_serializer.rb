class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_date, :end_date, :settled?, :group_id, :total

  belongs_to :group
  has_many :memberships
  has_many :members
  has_many :expenses
  has_many :invoices
end
