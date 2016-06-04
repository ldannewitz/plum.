class Expense < ApplicationRecord
  after_save :update_total

  belongs_to :event
  belongs_to :member, class_name: 'User'

  validates :event_id, :spender_id, :description, :amount, presence: true

  def update_total
    event = Event.find(self.event_id)
    event.total += self.amount
    event.save
  end
end
