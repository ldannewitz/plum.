class Group < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships
  has_many :events
  has_many :expenses, through: :events
end
