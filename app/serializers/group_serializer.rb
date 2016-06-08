class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :members
  has_many :events
  # has_many :expenses

  def members
    array = []
    object.members.each do |member|
      info = []
      # info << {"id": member.id}
      info << {"first_name": member.first_name}
      info << {"last_name": member.last_name}
      info << {"full_name": "#{member.first_name} #{member.last_name}"}
      array << info
    end
    array
  end

  def events
    array = []
    object.events.each do |event|
      info = []
      info << {"id": event.id}
      info << {"name": event.name}
      info << {"settled": event.settled?}
      info << {"tentative_balance": event.tentative_balance(object)}
      array << info
    end
    array
  end
end
