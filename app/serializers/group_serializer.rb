class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name

  # has_many :memberships
  has_many :members
  has_many :events
  # has_many :expenses

  def members
    array = []
    object.members.each do |member|
      info = []
      info << {"id": member.id}
      info << {"first_name": member.first_name}
      info << {"last_name": member.last_name}
      array << info
    end
    array
  end
end
