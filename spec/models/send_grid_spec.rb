require_relative '../rails_helper'

RSpec.describe SendGrid, type: :module do
  let!(:david) { User.create!(first_name: "David", last_name: "Ross", email: "drossgrandpa@gmail.com", password: "password") }
  let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password") }
  let (:cubs_infield) { Group.create!(name: "Cubs", members: [david, rizzo]) }
  let(:event) { Event.create!(name: "Roadtrip", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 20), settled?: false, group: cubs_infield, total: 10.00) }

  describe '#send_email' do
    it 'sends an email when a paypal invoice is generated' do
       expect { event.send_email("INV2-R4C9-AJ56-D6RM-YKV5", "yaboidex@gmail.com") }.to output("200\n{\"message\"=>\"success\"}\n").to_stdout
    end
  end
end
