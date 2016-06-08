class BillSerializer < ActiveModel::Serializer
  attributes :id, :event, :user, :amount, :satisfied?, :paypalUrl, :groupName

  # belongs_to :event
  # belongs_to :user

  def event
    Event.find(object.event_id).name
  end

  def user
    User.find(object.user_id).id
  end

end
