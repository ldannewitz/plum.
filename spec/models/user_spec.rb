require_relative '../rails_helper'

RSpec.describe User, type: :model do

  it 'has a first name' do
    should { validate_presence_of(:first_name) }
  end

  it 'has a last name' do
    should { validate_presence_of(:last_name) }
  end

  it 'has an email' do
    should { validate_presence_of(:email) }
  end

  it 'has secure password' do
    should { have_secure_password(:user) }
  end

  it 'has many memberships' do
    should { have_many(:memberships) }
  end

  it 'has many groups' do
    should { have_many(:groups) }
  end

  it 'has many events' do
    should { have_many(:events) }
  end

  it 'has many expenses' do
    should { have_many(:expenses) }
  end

  it 'has many invoices' do
    should { have_many(:invoices) }
  end

end
