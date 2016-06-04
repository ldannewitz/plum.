class MembershipSerializer < ActiveModel::Serializer
  attributes :id, :member_id, :group_id

  belongs_to :member
  belongs_to :group
end
