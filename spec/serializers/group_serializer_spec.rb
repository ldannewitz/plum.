require 'rails_helper'

describe GroupSerializer do
  let(:object) do
    build_serializable(name: "Cubs")
  end

  subject { serialize(object) }

  it { should include(:name => "Cubs") }
end
