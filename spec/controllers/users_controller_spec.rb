require "rails_helper"

RSpec.describe UsersController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :index
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

    it "loads all of the users into @users" do
      users = User.all
      silence_stream(STDOUT) do
        get :index
        expect(assigns(:users)).to match_array(users)
      end
    end

    # it "should serialize users JSON" do
    #   get :index
    #   expect(response.body).to eq(USERS_JSON)
    #   # expect(response).to eq(USERS_JSON)
    # end

  end

  describe "GET #show" do
    let(:user) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111") }

    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :show, params: { id: user.id }
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

    it "loads a user into @user" do
      silence_stream(STDOUT) do
        get :show, params: { id: user.id }
        expect(assigns(:user)).to match(user)
      end
    end

    # it "should serialize user JSON" do
    #   get :show, params: { id: user.id }
    #   expect(response.body).to eq(USER_JSON)
    #   # expect(response).to eq(USERS_JSON)
    # end
  end

  describe "GET #groups" do
    let(:user) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111") }

    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :groups, params: { id: user.id }
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

    it "loads a user's groups into @groups" do
      groups = user.groups
      get :groups, params: { id: user.id }
      expect(assigns(:groups)).to match_array(groups)
    end
  end

  describe "GET #events" do
    let(:user) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111") }

    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :events, params: { id: user.id }
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

    it "loads a user's events into @events" do
      silence_stream(STDOUT) do
        events = user.events
        get :events, params: { id: user.id }
        expect(assigns(:events)).to match_array(events)
      end
    end
  end

  describe "POST #new_event" do
    let(:json) { NEW_EVENT_JSON }

    it "responds successfully with an HTTP 204 status code" do
      silence_stream(STDOUT) do
        post :new_event, params: json
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(204)
        end
      end
    end

    # it "creates a new user event" do
    #   expect {post :new_event, params: json}.to change {Event.all.count}.by(1)
    # end
  end

  describe "POST #create" do
    let(:json) { NEW_USER_JSON }

    it "responds successfully with an HTTP 204 status code" do
      silence_stream(STDOUT) do
        post :create, params: json
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(204)
        end
      end
    end

    it "creates a new user" do
      silence_stream(STDOUT) do
        expect {post :create, params: json}.to change {User.all.count}.by(1)
      end
    end
  end
end
