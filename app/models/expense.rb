class Expense < ApplicationRecord
  after_save :update_total

  belongs_to :event
  belongs_to :member, foreign_key: 'spender_id', class_name: 'User'

  validates :event_id, :spender_id, :description, :amount, presence: true

  def update_total
    new_total = self.event.total + self.amount
    self.event.update(total: new_total)
  end
end
