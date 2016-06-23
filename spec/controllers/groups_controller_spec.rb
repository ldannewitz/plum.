require "rails_helper"

RSpec.describe GroupsController, :type => :controller do

  let!(:brad) { User.create!(first_name: "Brad", last_name: "Lindgren", email: "brad@gmail.com", password: "password", phone: "6666666666") }
  let!(:jon) { User.create!(first_name: "Jon", last_name: "Kaplan", email: "jon@gmail.com", password: "password", phone: "7777777777") }
  let!(:tom) { User.create!(first_name: "Tom", last_name: "Sok", email: "tom@gmail.com", password: "password", phone: "8888888888") }
  let!(:lisa) { User.create!(first_name: "Lisa", last_name: "Dannewitz", email: "lisa@gmail.com", password: "password", phone: "9999999999") }
  let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password") }
  let!(:kris) { User.create!(first_name: "Kris", last_name: "Bryant", email: "krisb6579@gmail.com", password: "password", phone: "2222222222") }

  let (:group) { Group.create(name: "Cool Kids", members: [brad, tom, lisa, rizzo, kris]) }

  # describe "POST #create" do
  #
  #   it "responds successfully with an HTTP 204 status code" do
  #     # silence_stream(STDOUT) do
  #       NEW_GROUP_JSON[:user_id] = jon.id
  #       post :create, params: NEW_GROUP_JSON
  #       aggregate_failures "testing response" do
  #         expect(response).to be_success
  #         expect(response).to have_http_status(204)
  #       end
  #     # end
  #   end
  #
  #   it "creates a new group" do
  #     # silence_stream(STDOUT) do
  #       expect {post :create, params: NEW_GROUP_JSON}.to change { Group.all.count }.by(1)
  #     end
  #   # end
  # end

  describe "GET #show" do

    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :show, params: { id: group.id }
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

    it "loads a group into @group" do
      silence_stream(STDOUT) do
        get :show, params: { id: group.id }
        expect(assigns(:group)).to match(group)
      end
    end
  end

  describe "GET #members" do

    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :members, params: { id: group.id }
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

    it "loads a group's members into @members" do
      silence_stream(STDOUT) do
        members = group.members
        get :members, params: { id: group.id }
        expect(assigns(:members)).to match_array(members)
      end
    end
  end

  describe "GET #events" do

    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :events, params: { id: group.id }
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

    it "loads a group's events into @events" do
      silence_stream(STDOUT) do
        events = group.events
        get :events, params: { id: group.id }
        expect(assigns(:events)).to match_array(events)
      end
    end
  end
end
