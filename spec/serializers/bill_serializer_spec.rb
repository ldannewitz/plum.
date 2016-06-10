require 'rails_helper'

describe BillSerializer, :type => :serializer do
  let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111") }
  let!(:kris) { User.create!(first_name: "Kris", last_name: "Bryant", email: "krisb6579@gmail.com", password: "password", phone: "2222222222") }

  let!(:group) { Group.create(name: "DBC", members: [rizzo, kris]) }
  let!(:event) { Event.create!(name: "Rafting", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 10), settled?: false, group: group) }

  let(:object) do
    build_serializable(
      event_id: event.id,
      user_id: kris.id,
      bill_type: 'credit',
      amount: 1.23,
      satisfied?: false,
      paypal_id: 'INV2-MTJR-D2UY-QTGZ-XZE5',
    )
  end

  subject { serialize(object) }

  it { should include(:event => "Rafting") }
  it { should include(:amount => 1.23) }
  it { should include(:paypalurl => nil) }
end
