require 'rails_helper'

describe EventSerializer do
  let!(:brad) { User.create!(first_name: "Brad", last_name: "Lindgren", email: "brad@gmail.com", password: "password") }
  let!(:lisa) { User.create!(first_name: "Lisa", last_name: "Dannewitz", email: "lisa@gmail.com", password: "password") }
  let!(:dbc) { Group.create!(name: "DBC", members: [ brad, lisa ]) }
  let(:event) { Event.create!(name: "Hackaton", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 6), group: dbc) }
  let!(:food) { Expense.create!(event: event, spender_id: lisa.id, description: "food", amount: 60.34, location: "Davenport") }
  let!(:snacks) { Expense.create!(event: event, spender_id: lisa.id, description: "snacks", amount: 5.22, location: "DeKalb") }
  let!(:bill) { Bill.create!(event: event, user: brad, bill_type: 'debit', amount: 32.78) }

  let(:object) do
    build_serializable(
      name: "Hackaton",
      start_date: DateTime.new(2016, 6, 4),
      end_date: DateTime.new(2016, 6, 6),
      settled?: false,
      group: dbc,
      total: 10.00,
      members: [ brad, lisa ],
      expenses: [ food, snacks ],
      bills: [bill]
    )
  end

  subject { serialize(object) }

  it { should include(:name => "Hackaton") }
  it { should include(:start_date => DateTime.new(2016, 6, 4)) }
  it { should include(:end_date => DateTime.new(2016, 6, 6)) }
  it { should include(:settled? => false) }
  it { should include(:group => {"id" => dbc.id, "name" => "DBC"}) }
  it { should include(:total => 10.00) }
end
