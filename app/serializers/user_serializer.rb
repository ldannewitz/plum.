class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone

  # has_many :memberships
  has_many :groups
  has_many :events
  has_many :expenses
  has_many :bills

  def name
    "#{object.first_name} #{object.last_name}"
  end

  def groups
    array = []
    object.groups.each do |group|
      info = []
      # info << {"id": group.id}
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
      info << {"tentative_balance": event.tentative_balance(object)}
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
    object.bills.each do |bill|
      info = []
      info << {"amount": bill.amount}
      info << {"for_event": bill.event.name}
      array << info
    end
    array
  end
end
