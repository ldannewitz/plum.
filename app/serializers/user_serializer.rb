class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone

  has_many :groups
  has_many :events
  has_many :expenses
  has_many :bills

  def groups
    array = []
    object.groups.each do |group|
      info = []
      info << {"id": group.id}
      info << {"name": group.name}
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
      info << {"tentativebalance": event.tentativebalance(object)}
      array << info
    end
    array
  end

  def expenses
    array = []
    object.expenses.each do |expense|
      info = []
      info << {"description": expense.description}
      info << {"amount": expense.amount}
      info << {"for_event": expense.event.name}
      array << info
    end
    array
  end

  def bills
    array = []
    unless object.bills.nil?
      object.bills.each do |bill|
        info = []
        info << {"amount": bill.amount}
        info << {"for_event": bill.event.name}
        info << {"paypalurl": bill.paypalurl}
        info << {"groupname": bill.groupname}
        array << info
      end
    end
    array
  end
end
