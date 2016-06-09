# require 'rails_helper'
#
# describe GroupSerializer do
#   let(:object) do
#     build_serializable(
#       name: "Cubs",
#       members: [User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111")],
#       events: [Event.create!(name: "Wine Tour", start_date: DateTime.new(2016, 6, 2), end_date: DateTime.new(2016, 6, 7), settled?: false, group: Group.find_or_create_by!(name: "Cubs"))])
#   end
#
#   subject { serialize(object) }
#
#   it { should include(:name => "Cubs") }
# end
