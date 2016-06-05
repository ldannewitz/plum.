require_relative '../rails_helper'

RSpec.describe Event, type: :model do

  it 'has a name' do
    should { validate_presence_of(:name) }
  end

  it 'has a start' do
    should { validate_presence_of(:start) }
  end

  it 'has an end' do
    should { validate_presence_of(:end) }
  end

  it "knows if it's settled" do
    should { validate_presence_of(:settled?) }
  end

  it "has a group id" do
    should { validate_presence_of(:group_id) }
  end

  it "has a total" do
    should { validate_presence_of(:total) }
  end

  it 'belongs to a group' do
    should { belong_to(:group) }
  end

  it 'has many memberships' do
    should { have_many(:memberships) }
  end

  it 'has many members' do
    should { have_many(:members) }
  end

  it 'has many expenses' do
    should { have_many(:expenses) }
  end

  it 'has many bills' do
    should { have_many(:bills) }
  end

end
