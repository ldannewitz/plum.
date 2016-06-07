class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_date, :end_date, :settled?, :group_id, :total

  belongs_to :group
  # has_many :memberships
  has_many :members
  has_many :expenses
  has_many :bills

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
end
