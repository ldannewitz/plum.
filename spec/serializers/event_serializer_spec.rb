require 'rails_helper'

describe EventSerializer do
  let(:object) do
    build_serializable(
      name: "Hackaton",
      start_date: DateTime.new(2016, 6, 4),
      end_date: DateTime.new(2016, 6, 6),
      settled?: false,
      group_id: 1,
      total: 10.00,
    )
  end

  subject { serialize(object) }

  it { should include(:name => "Hackaton") }
  it { should include(:start_date => DateTime.new(2016, 6, 4)) }
  it { should include(:end_date => DateTime.new(2016, 6, 6)) }
  it { should include(:settled? => false) }
  it { should include(:group_id => 1) }
  it { should include(:total => 10.00) }
end
