class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone

  has_many :memberships
  has_many :groups
  has_many :events
  has_many :expenses
  has_many :invoices

  def name
    "#{object.first_name} #{object.last_name}"
  end
end
