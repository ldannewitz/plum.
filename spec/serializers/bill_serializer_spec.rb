require 'rails_helper'

describe BillSerializer do
  let(:object) do
    build_serializable(
      event_id: 1,
      user_id: 1,
      bill_type: 'credit',
      amount: 1.23,
      satisfied?: false,
    )
  end

  subject { serialize(object) }

  it { should include(:event_id => 1) }
  it { should include(:user_id => 1) }
  it { should include(:bill_type => 'credit') }
  it { should include(:amount => 1.23) }
  it { should include(:satisfied? => false) }
end
