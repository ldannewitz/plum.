require_relative '../rails_helper'

RSpec.describe Bill, type: :model do
  let!(:member) { User.create!(first_name: 'First', last_name: 'Last', email: 'e@mail.com', password: 'password') }
  let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password") }
  let (:cubs_infield) { Group.create!(name: "Cubs", members: [member, rizzo]) }
  let(:event) { Event.create!(name: "Roadtrip", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 20), settled?: false, group: cubs_infield, total: 10.00) }
  let(:bill) { Bill.create!(event: event, user: member, bill_type: 'debit', amount: -74.48, satisfied?: false) }

  it 'has an event id' do
    should { validate_presence_of(:event_id) }
  end

  it 'has a user id' do
    should { validate_presence_of(:user_id) }
  end

  it 'has a bill_type' do
    should { validate_presence_of(:bill_type) }
  end

  it 'has a amount' do
    should { validate_presence_of(:amount) }
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

  it "has a paypal url if it's a debit bill" do
    expect(bill.paypalurl).not_to be_nil
  end

  it 'has a groupname' do
    expect(bill.groupname).to eq('Cubs')
  end

  describe '#get_invoice_details' do
    it "updates a bill to satisfy if it's been paid" do
      bill.update(paypal_id: "INV2-R4C9-AJ56-D6RM-YKV5")
      expect{bill.get_invoice_details}.to change{bill.satisfied?}
    end

    it 'returns nil for credit bills' do
      bill.update(bill_type: 'credit')
      expect(bill.get_invoice_details).to be_nil
    end

    it "returns an error if the bill doesn' have an invoice" do
      expect(bill.get_invoice_details).to include(PayPal::SDK::Invoice::DataTypes::ErrorData)
    end
  end
end
