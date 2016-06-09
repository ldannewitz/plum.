require_relative '../rails_helper'

RSpec.describe Group, type: :model do

  let!(:member) { User.create!(first_name: 'First', last_name: 'Last', email: 'e@mail.com', password: 'password') }
  let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password") }
  let (:cubs_infield) { Group.create!(name: "Cubs", members: [member, rizzo]) }

  # @event = Event.create!(name: "Roadtrip", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 20), settled?: false, group: @cubs_infield, total: 10.00)

  it 'has a name' do
    should { validate_presence_of(:name) }
  end

  it 'has many memberships' do
    should { have_many(:memberships) }
  end

  it 'has many members' do
    should { have_many(:members) }
  end

  it 'has many events' do
    should { have_many(:events) }
  end

  it 'has many expenses' do
    should { have_many(:expenses) }
  end

  describe '#add_members' do
    it 'adds the group creator and members' do
      expect{cubs_infield.add_members([rizzo],member.id)}.to change {cubs_infield.members.count}.by(2)
    end
  end

  # describe '#validate_members' do
  #   it 'makes sure a group has 2+ members' do
  #     expect{cubs_infield.validate_members}.to change{cubs_infield.errors}.by(1)
  #   end
  # end

end
