class MembershipSerializer < ActiveModel::Serializer
  attributes :member_id, :group_id

  belongs_to :member
  belongs_to :group
end
