require_relative '../rails_helper'

RSpec.describe Event, type: :model do

  let!(:david) { User.create!(first_name: "David", last_name: "Ross", email: "drossgrandpa@gmail.com", password: "password") }
  let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password") }
  let (:cubs_infield) { Group.create!(name: "Cubs", members: [david, rizzo]) }
  let(:event) { Event.create!(name: "Roadtrip", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 20), settled?: false, group: cubs_infield, total: 10.00) }

  it 'has a name' do
    should { validate_presence_of(:name) }
  end

  it 'has a start' do
    should { validate_presence_of(:start) }
  end

  it 'has an end' do
    should { validate_presence_of(:end) }
  end

  it "has a group" do
    should { validate_presence_of(:group) }
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

  describe '#expired?' do
    it 'returns false when the event is live' do
      expect(event.expired?).to be(false)
    end

    # it 'calls #generate_invoices when the event is expired' do
    #   @event.end_date = DateTime.new(2016, 6, 5)
    #   # puts event.end_date
    #   # puts DateTime.now
    #   # puts event.end_date < DateTime.now
    #   @event.should_receive(:generate_invoices)
    #   @event.expired?
    # end
  end

  describe '#even_split' do
    it 'splits the event total between the group members' do
      expect(event.even_split).to eq(5)
    end
  end

  describe '#get_member_balances' do
    it 'determines the balance of each group members' do
      expect(event.get_member_balances).to include("drossgrandpa@gmail.com"=>-5.0)
    end
  end

  describe '#generate_invoices' do
    let!(:expense) { Expense.create!(event: @event, spender_id: @member.id, description: "Redbull", amount: 6.20) }
    let!(:friend) { User.create!(first_name: 'Friend', last_name: 'Person', email: 'em@ail.com', password: 'password') }
    let!(:membershippp) { Membership.create!(member: friend, group: @cubs_infield) }

    # it 'generates a debit bill for a user who owes money' do
    #   @member.expenses.first.update(amount: 0)
    #   expect{@event.generate_invoices}.to change{Bill.all.count}.by(2)
    #   expect(@member.bills.first.bill_type).to eq('debit')
    # end
    # 
    # it 'generates a credit bill for a user who is owed money' do
    #   @event.update(total: 10)
    #   expect{@event.generate_invoices}.to change{@member.bills.count}.by(1)
    #   expect(@member.bills.first.bill_type).to eq('credit')
    # end
    #
    # it 'generates an 0 invoice if a user has no balance' do
    #   @event.update(total: 12.4)
    #   expect{@event.generate_invoices}.not_to change{@member.bills.count}
    # end
  end

  describe '#all_bills_paid?' do
    it "returns nil if an event has no bills" do
      expect(event.all_bills_paid?).to be_empty
    end

    it "returns false if all of event's invoices are not satisfied" do
      event.expenses << Expense.find_or_create_by!(event_id: event.id, spender_id: david.id, description: "gas", amount: 27.34, location: "Chicago")
      Bill.create!(event: event, user: david, bill_type: 'debit', amount: 4567.89, satisfied?: false)
      expect(event.all_bills_paid?).to eq(false)
    end

    it "returns settled if event's invoices and payouts are satisfied" do
      event.update(settled?: true)
      expect(event.all_bills_paid?).to eq("This event is settled")
    end
  end

  describe '#settle_event' do
    it 'settles an event when all of its bills are satisfied' do
      event.expenses << Expense.find_or_create_by!(event_id: event.id, spender_id: david.id, description: "gas", amount: 27.34, location: "Chicago")
      Bill.create!(event: event, user: david, bill_type: 'debit', amount: 4567.89, satisfied?: true)
      expect{event.settle_event}.to change(event, :settled?)
    end

    it "returns 'not satisfied' when an event has unpaid bills" do
      event.expenses << Expense.find_or_create_by!(event_id: event.id, spender_id: david.id, description: "gas", amount: 27.34, location: "Chicago")
      Bill.create!(event: event, user: david, bill_type: 'debit', amount: 4567.89, satisfied?: false)
      expect(event.settle_event).to eq('not satisfied')
    end
  end

end
