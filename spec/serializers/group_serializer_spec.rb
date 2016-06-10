require 'rails_helper'

describe GroupSerializer do
  let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111") }
  let!(:lisa) { User.create!(first_name: "Lisa", last_name: "Dannewitz", email: "lisa@gmail.com", password: "password", phone: "9999999999") }
  let!(:cubs) {Group.create!(name: "Cubs", members: [rizzo, lisa]) }
  let!(:tour) { Event.create!(name: "Wine Tour", start_date: DateTime.new(2016, 6, 2), end_date: DateTime.new(2016, 6, 7), group: cubs) }

  let(:object) do
    build_serializable(
      name: "Cubs",
      members: [ rizzo, lisa ],
      events: [ tour ])
  end

  subject { serialize(object) }

  it { should include(:name => "Cubs") }
end
