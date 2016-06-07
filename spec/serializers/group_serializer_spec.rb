require 'rails_helper'

describe GroupSerializer do
  let(:object) do
    build_serializable(name: "Cubs", members: [User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111")])
  end

  subject { serialize(object) }

  it { should include(:name => "Cubs") }
end
