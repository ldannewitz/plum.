require 'rails_helper'

describe UserSerializer do
  let(:object) do
    build_serializable(
      first_name: "Kris",
      last_name: "Bryant",
      email: "kbryant@gmail.com",
      password: "password",
      phone: "2222222222",
    )
  end

  subject { serialize(object) }

  it { should include(:name => "Kris Bryant") }
  it { should include(:email => "kbryant@gmail.com") }
  it { should include(:phone => "2222222222") }
end
