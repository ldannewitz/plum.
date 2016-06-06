require "rails_helper"

RSpec.describe EventsController, :type => :controller do

  describe "GET #show" do
    let(:cubs_infield) {Group.create!(name: "Cubs")}
    let(:event) {Event.create!(name: "Roadtrip", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 6), settled?: false, group: cubs_infield)}

    it "responds successfully with an HTTP 200 status code" do
      get :show, params: { id: event.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads an event into @event" do
      get :show, params: { id: event.id }

      expect(assigns(:event)).to match(event)
    end
  end
end
