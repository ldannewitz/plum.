require_relative '../rails_helper'

RSpec.describe Expense, type: :model do

  let!(:david) { User.create!(first_name: "David", last_name: "Ross", email: "drossgrandpa@gmail.com", password: "password") }
  let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password") }
  let!(:group) {
    group = Group.create!(name: 'RAR', members: [david, rizzo])
  }
  let!(:event) { Event.create!(name: 'Saturday', start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 6), group: group, total: 10.00) }
  let!(:expense) { Expense.create!(event: event, spender_id: david.id, description: "TP", amount: 1.20) }

  it 'has an event id' do
    should { validate_presence_of(:event) }
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
      expect{expense.save!}.to change {expense.event.total}
    end
  end

end
