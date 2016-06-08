require 'rails_helper'

describe UserSerializer do
  let(:group) { Group.find_or_create_by!(name: "DBC") }
  let(:event) { Event.create!(name: "Rafting", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 10), settled?: false, group: group) }
  let(:kris) { User.create!(first_name: "Kris", last_name: "Bryant", email: "krisb6579@gmail.com", password: "password", phone: "2222222222") }

  let(:object) do
    build_serializable(
      first_name: "Kris",
      last_name: "Bryant",
      email: "kbryant@gmail.com",
      password: "password",
      phone: "2222222222",
      groups: [group],
      events: [event],
      expenses: [Expense.find_or_create_by!(event: event, spender_id: kris.id, description: "food", amount: 60.34, location: "Davenport"),
      Expense.find_or_create_by!(event: event, spender_id: kris.id, description: "snacks", amount: 5.21, location: "DeKalb")],
      bills: [Bill.find_or_create_by!(event: event, user: kris, bill_type: 'credit', amount: 4567.89, satisfied?: false)],
    )
  end

  subject { serialize(object) }

  it { should include(:name => "Kris Bryant") }
  it { should include(:email => "kbryant@gmail.com") }
  it { should include(:phone => "2222222222") }
end
