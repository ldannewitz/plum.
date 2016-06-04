require_relative '../rails_helper'

RSpec.describe Group, type: :model do

  it 'has a name' do
    should { validate_presence_of(:name) }
  end

  it 'has many memberships' do
    should { have_many(:memberships) }
  end

  it 'has many members' do
    should { have_many(:members) }
  end

  it 'has many events' do
    should { have_many(:events) }
  end

  it 'has many expenses' do
    should { have_many(:expenses) }
  end

end
