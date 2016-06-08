class BillSerializer < ActiveModel::Serializer
  attributes :id, :event, :user, :amount, :satisfied?, :paypal_url

  # belongs_to :event
  # belongs_to :user

  def event
    Event.find(object.event_id).name
  end

  def user
    User.find(object.user_id).id
  end

  def paypal_url
    "https://www.sandbox.paypal.com/us/cgi-bin/?cmd=_pay-inv&id=#{object.paypal_id}"
  end
end
