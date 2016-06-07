class Group < ApplicationRecord
  has_many :memberships
  has_many :members, through: :memberships, class_name: 'User'
  has_many :events
  has_many :expenses, through: :events

  validates :name, presence: true

  def add_members(new_members)
    new_members.each do |member|
      self.members << User.find_by(email: member[:email])
      self.save
    end
  end
end
