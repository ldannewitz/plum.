class Event < ActiveRecord::Base
  belongs_to :group
  has_many :memberships, through: :group
  has_many :members, through: :memberships
  has_many :expenses
  has_many :invoices
end
