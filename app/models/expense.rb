class Expense < ApplicationRecord
  after_save :update_total
  # before_save :update_total

  belongs_to :event
  belongs_to :member, foreign_key: 'spender_id', class_name: 'User'

  validates :event_id, :spender_id, :description, :amount, presence: true

  def update_total
    # puts 'updating'
    # puts Event.find(self.event_id).id

    # event = Event.find(self.event_id)

    # puts event.total
    # puts self.amount
    # event.total += self.amount

    new_total = self.event.total + self.amount
    # event.update(total: new_total)

    self.event.update(total: new_total)


    # event.save!
    # puts 'saved'
    # puts event.id
    # puts event.total
    # puts self.event.id
    # puts self.event.total
    # puts self.attributes
  end
end
