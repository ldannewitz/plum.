require 'rails_helper'

describe ExpenseSerializer do
  let(:object) do
    build_serializable(
      event_id: 1,
      spender_id: 1,
      description: "energy drinks",
      amount: 10000000000,
      location: "CVS",
    )
  end

  subject { serialize(object) }

  it { should include(:event_id => 1) }
  it { should include(:spender_id => 1) }
  it { should include(:description => "energy drinks") }
  it { should include(:amount => 10000000000) }
  it { should include(:location => "CVS") }
end
