# require 'rails_helper'
#
# describe UserSerializer, :type => :serializer do
#   let!(:brad) { User.create!(first_name: "Brad", last_name: "Lindgren", email: "brad@gmail.com", password: "password", phone: "6666666666") }
#   let!(:jon) { User.create!(first_name: "Jon", last_name: "Kaplan", email: "jon@gmail.com", password: "password", phone: "7777777777") }
#   let!(:tom) { User.create!(first_name: "Tom", last_name: "Sok", email: "tom@gmail.com", password: "password", phone: "8888888888") }
#   let!(:lisa) { User.create!(first_name: "Lisa", last_name: "Dannewitz", email: "lisa@gmail.com", password: "password", phone: "9999999999") }
#
#   let!(:group) { Group.create(name: "DBC", members: [brad, jon, tom, lisa]) }
#   let!(:event) { Event.create!(name: "Rafting", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 10), settled?: false, group: group) }
#   let!(:food) { Expense.create!(event: event, spender_id: brad.id, description: "food", amount: 60.34, location: "Davenport") }
#   let!(:snacks) { Expense.create!(event: event, spender_id: brad.id, description: "snacks", amount: 5.21, location: "DeKalb") }
#   let!(:bill) { Bill.find_or_create_by!(event: event, user: brad, bill_type: 'credit', amount: 4567.89, satisfied?: false) }
#
#   let(:object) do
#     build_serializable(
#       first_name: "Kris",
#       last_name: "Bryant",
#       email: "kbryant@gmail.com",
#       password: "password",
#       phone: "2222222222",
#       groups: [group],
#       events: [event],
#       expenses: [food, snacks],
#       bills: [bill]
#     )
#   end
#
#   subject { serialize(object) }
#
#   it { should include(:email => "kbryant@gmail.com") }
#   it { should include(:phone => "2222222222") }
# end
