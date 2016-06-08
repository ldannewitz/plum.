require 'securerandom'
class User < ApplicationRecord
  before_create :set_auth_token
  has_secure_password

  has_many :memberships, foreign_key: :member_id, dependent: :destroy
  has_many :groups, through: :memberships
  has_many :events, through: :groups
  has_many :expenses, foreign_key: :spender_id
  has_many :bills

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  def name
    "#{self.first_name} #{self.last_name}"
  end

  # def tentative_balance_for_all_events
  #   total = 0
  #   self.events.each do |event|
  #     total += find_member_total(event.expenses, self) - event.even_split
  #   end
  #   total
  # end

  private

  def set_auth_token
    return if auth_token.present?
    self.auth_token = generate_auth_token
  end

  def generate_auth_token
    SecureRandom.hex(15)
  end

end
