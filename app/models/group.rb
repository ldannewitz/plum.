class Group < ApplicationRecord
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, class_name: 'User'
  has_many :events, dependent: :destroy
  has_many :expenses, through: :events

  validates :name, presence: true
  # validate :validate_members

  def add_members(new_members, creator_id)
    add_creator = true
    new_members.each do |member|
       self.members << member
       add_creator = false if member.id == creator_id
    end
    self.members << User.find(creator_id) if add_creator
    self.save
  end

  def validate_members
    if self.members.length < 2
      errors.add(:members, 'A group needs two or more members')
    end
  end
end
