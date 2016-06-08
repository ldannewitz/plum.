require 'rails_helper'

describe EventSerializer do
  let(:group) { Group.find_or_create_by!(name: "DBC") }
  let (:member) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111") }
  let(:event) { Event.create!(name: "Hackaton", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 6), group: group) }

  let(:object) do
    build_serializable(
      name: "Hackaton",
      start_date: DateTime.new(2016, 6, 4),
      end_date: DateTime.new(2016, 6, 6),
      settled?: false,
      group_id: group.id,
      total: 10.00,
      members: [member],
      expenses: [Expense.find_or_create_by!(event: event, spender_id: member.id, description: "food", amount: 60.34, location: "Davenport"),
      Expense.find_or_create_by!(event: event, spender_id: member.id, description: "snacks", amount: 5.21, location: "DeKalb")],
    )
  end

  subject { serialize(object) }

  it { should include(:name => "Hackaton") }
  it { should include(:start_date => DateTime.new(2016, 6, 4)) }
  it { should include(:end_date => DateTime.new(2016, 6, 6)) }
  it { should include(:settled? => false) }
  it { should include(:group_id => group.id) }
  it { should include(:total => 10.00) }
end
