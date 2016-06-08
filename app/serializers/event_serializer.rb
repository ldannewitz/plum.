class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_date, :end_date, :settled?, :group_id, :total #, :tentative_balance

  belongs_to :group
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

  def expenses
    array = []
    object.expenses.each do |expense|
      info = []
      # info << {"id": expense.id}
      info << {"description": expense.description}
      info << {"amount": expense.amount}
      array << info
    end
    array
  end

  def bills
    array = []
    unless object.bills.nil?
      object.bills.each do |bill|
        info = []
        info << {"bill_for": User.find(bill.user_id).name}
        info << {"amount": bill.amount}
        info << {"for_event": bill.event.name}
        array << info
      end
    end
    array
  end
end
