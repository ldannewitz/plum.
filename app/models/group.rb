class Group < ApplicationRecord
  has_many :memberships
  has_many :members, through: :memberships, class_name: 'User'
  has_many :events
  has_many :expenses, through: :events

  validates :name, presence: true
end
