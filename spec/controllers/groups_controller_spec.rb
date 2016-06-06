require "rails_helper"

RSpec.describe GroupsController, :type => :controller do

  describe "POST #create" do
    let(:json) { NEW_GROUP_JSON }

    it "responds successfully with an HTTP 204 status code" do
      post :create, params: json
      expect(response).to be_success
      expect(response).to have_http_status(204)
    end

    it "creates a new group" do
      expect {post :create, params: json}.to change {Group.all.count}.by(1)
    end
  end

  describe "GET #show" do
    let(:group) {Group.create!(name: "Cubs")}

    it "responds successfully with an HTTP 200 status code" do
      get :show, params: { id: group.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads a group into @group" do
      get :show, params: { id: group.id }

      expect(assigns(:group)).to match(group)
    end
  end

  describe "GET #members" do
    let(:group) {Group.create!(name: "Cubs")}

    it "responds successfully with an HTTP 200 status code" do
      get :members, params: { id: group.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads a group's members into @members" do
      members = group.members
      get :members, params: { id: group.id }

      expect(assigns(:members)).to match_array(members)
    end
  end

  describe "POST #add_members" do
    let(:group) {Group.create!(name: "Cubs")}
    let(:json) { NEW_MEMBER_JSON }

    it "responds successfully with an HTTP 204 status code" do
      json["id"] = group.id
      post :add_members, params: json
      expect(response).to be_success
      expect(response).to have_http_status(204)
    end

    # it "adds members to a group" do
    #   expect {post :add_members, params: json}.to change {Membership.all.count}
    # end
  end

  describe "GET #events" do
    let(:group) {Group.create!(name: "Cubs")}

    it "responds successfully with an HTTP 200 status code" do
      get :events, params: { id: group.id }
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads a group's events into @events" do
      events = group.events
      get :events, params: { id: group.id }

      expect(assigns(:events)).to match_array(events)
    end
  end
end
