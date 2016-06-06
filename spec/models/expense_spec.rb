require_relative '../rails_helper'

RSpec.describe Expense, type: :model do

  let!(:member) { User.create!(first_name: 'First', last_name: 'Last', email: 'e@mail.com', password: 'password') }

  let!(:group) { Group.create!(name: 'RAR') }

  let!(:membership) { Membership.create!(member: member, group: group) }

  let!(:event) { Event.create!(name: 'Saturday', start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 6), group: group, total: 10.00) }

  let!(:expense) { Expense.new(event: event, spender_id: member.id, description: "TP", amount: 1.20) }

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

  describe '#update_total' do
    it 'updates event total' do
      p member
      p group
      p membership
      p event
      p expense

      p User.all.count

      expect{expense.save!}.to change {expense.event.total}
    end
  end

end
