class Invoice < ActiveRecord::Base
  belongs_to :event
  belongs_to :group, through: :event
  belongs_to :user
end
