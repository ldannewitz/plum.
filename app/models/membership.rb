class Membership < ActiveRecord::Base
  belongs_to :member
  belongs_to :group

  validates :member_id, :group_id, presence: true
end
