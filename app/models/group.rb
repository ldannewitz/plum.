class Group < ApplicationRecord
  has_many :memberships
  has_many :members, through: :memberships, class_name: 'User'
  has_many :events
  has_many :expenses, through: :events
  # belongs_to :user, class_name: "User"

  validates :name, presence: true

  def add_members(new_members, creator_id)
    new_members << User.find(creator_id)
    new_members.each do |member|
      self.members << User.find_by(email: member[:email])
    end
    self.save
  end
end
