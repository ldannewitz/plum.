require_relative '../rails_helper'

RSpec.describe Expense, type: :model do

  it 'has an event id' do
    should { validate_presence_of(:event_id) }
  end

  it 'has a spender id' do
    should { validate_presence_of(:spender_id) }
  end

  it 'has a description' do
    should { validate_presence_of(:description) }
  end

  it 'has a amount' do
    should { validate_presence_of(:amount) }
  end

  it 'belongs to an event' do
    should { belong_to(:event) }
  end

  it 'belongs to a member' do
    should { belong_to(:member) }
  end

end
