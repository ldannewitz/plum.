require 'rails_helper'

describe MembershipSerializer do
  let(:object) do
    build_serializable(
      member_id: 1,
      group_id: 1,
    )
  end

  subject { serialize(object) }

  it { should include(:member_id => 1) }
  it { should include(:group_id => 1) }
end
