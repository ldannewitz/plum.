class Membership < ApplicationRecord
  belongs_to :member, class_name: 'User'
  belongs_to :group

  validates :member_id, :group_id, presence: true
end
