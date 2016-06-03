class Expense < ActiveRecord::Base
  belongs_to :event
  belongs_to :member, through: :event
end
