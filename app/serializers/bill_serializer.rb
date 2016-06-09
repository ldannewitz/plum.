class BillSerializer < ActiveModel::Serializer
  attributes :id, :event, :amount, :paypalurl, :groupname

  def event
    Event.find(object.event_id).name
  end

end
