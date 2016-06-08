require 'rails_helper'

describe BillSerializer, :type => :serializer do
  let(:group) { Group.find_or_create_by!(name: "DBC") }
  let(:event) { Event.create!(name: "Rafting", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 10), settled?: false, group: group) }
  let(:kris) { User.create!(first_name: "Kris", last_name: "Bryant", email: "krisb6579@gmail.com", password: "password", phone: "2222222222") }

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
  it { should include(:user => kris.id) }
  it { should include(:amount => 1.23) }
  it { should include(:satisfied? => false) }
  # it { should include(:paypal_url => "https://www.sandbox.paypal.com/us/cgi_bin/?cmd=_pay-inv&id=INV2-MTJR-D2UY-QTGZ-XZE5") }
end
