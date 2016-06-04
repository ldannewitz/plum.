require_relative '../rails_helper'

RSpec.describe Invoice, type: :model do
  it 'has an event id' do
    should { validate_presence_of(:event_id) }
  end

  it 'has a user id' do
    should { validate_presence_of(:user_id) }
  end

  it 'has a invoice_type' do
    should { validate_presence_of(:invoice_type) }
  end

  it 'has a amount' do
    should { validate_presence_of(:amount) }
  end

  it 'knows if it has been paid' do
    should { validate_presence_of(:satisfied?) }
  end

  it 'belongs to an event' do
    should { belong_to(:event) }
  end

  it 'belongs to a group' do
    should { belong_to(:group) }
  end

  it 'belongs to a user' do
    should { belong_to(:user) }
  end
end
