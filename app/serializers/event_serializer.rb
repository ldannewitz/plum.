class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :start_date, :end_date, :settled?, :group_id, :total #, :tentativebalance

  belongs_to :group
  has_many :members
  has_many :expenses
  has_many :bills

  def members
    array = []
    @event = Event.find_by(name: object.name)
    object.members.each do |member|
      info = []
      # info << {"id": member.id}
      info << {"first_name": member.first_name}
      info << {"last_name": member.last_name}
      info << {"full_name": "#{member.first_name} #{member.last_name}"}
      info << {"tentativebalance": @event.tentativebalance(member)}
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
      info << {"location": expense.location}
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

  # def tentativebalance
  #   member = User.find(event.)
  #   (find_member_total(object.expenses, member) - self.even_split).round(2)
  # end
end
