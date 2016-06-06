require "rails_helper"

RSpec.describe EventsController, :type => :controller do

  # before(:each) do
  #   silence_stream(STDOUT) do
  #     yield
  #   end
  # end

  describe "GET #show" do
    let(:cubs_infield) { Group.create!(name: "Cubs") }
    let(:event) { Event.create!(name: "Roadtrip", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 6), settled?: false, group: cubs_infield) }

    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :show, params: { id: event.id }
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

    it "loads an event into @event" do
      silence_stream(STDOUT) do
        get :show, params: { id: event.id }
        expect(assigns(:event)).to match(event)
      end
    end
  end
end
