class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :memberships
  has_many :members
  has_many :events
  has_many :expenses
end
