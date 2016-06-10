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

    # test "should render user serializer" do
    #   get :index
    #   assert_serializer UserSerializer, 'user'
    # end

    # it "should serialize users JSON" do
    #   get :index
    #   expect(response.body).to eq(USERS_JSON)
    #   # expect(response).to eq(USERS_JSON)
    # end

  end


  describe "GET #show" do
    let!(:david) { User.create!(first_name: "David", last_name: "Ross", email: "drossgrandpa@gmail.com", password: "password") }
    let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111") }
    let!(:cubs_infield) { Group.create!(name: "Cubs", members: [david, rizzo]) }
    let!(:event) { Event.create!(name: "Roadtrip", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 20), settled?: false, group: cubs_infield, total: 10.00) }

    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :show, params: { id: rizzo.id }
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

    it "loads a user into @user" do
      silence_stream(STDOUT) do
        get :show, params: { id: rizzo.id }
        expect(assigns(:user)).to match(rizzo)
      end
    end

    # it "should serialize user JSON" do
    #   get :show, params: { id: user.id }
    #   expect(response.body).to eq(USER_JSON)
    #   # expect(response).to eq(USERS_JSON)
    # end
  end


  describe "GET #groups" do
    let!(:david) { User.create!(first_name: "David", last_name: "Ross", email: "drossgrandpa@gmail.com", password: "password") }
    let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111") }
    let!(:cubs_infield) { Group.create!(name: "Cubs", members: [david, rizzo]) }
    let!(:event) { Event.create!(name: "Roadtrip", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 20), settled?: false, group: cubs_infield, total: 10.00) }

    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :groups, params: { id: david.id }
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

    it "loads a user's groups into @groups" do
      silence_stream(STDOUT) do
        groups = david.groups
        get :groups, params: { id: david.id }
        expect(assigns(:groups)).to match_array(groups)
      end
    end
  end


  describe "GET #events" do
    let!(:david) { User.create!(first_name: "David", last_name: "Ross", email: "drossgrandpa@gmail.com", password: "password") }
    let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111") }
    let!(:cubs_infield) { Group.create!(name: "Cubs", members: [david, rizzo]) }
    let!(:event) { Event.create!(name: "Roadtrip", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 20), settled?: false, group: cubs_infield, total: 10.00) }

    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :events, params: { id: david.id }
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

    it "loads a user's events into @events" do
      silence_stream(STDOUT) do
        events = david.events
        get :events, params: { id: david.id }
        expect(assigns(:events)).to match_array(events)
      end
    end
  end


  describe "GET #bills" do
    let!(:david) { User.create!(first_name: "David", last_name: "Ross", email: "drossgrandpa@gmail.com", password: "password") }
    let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111") }
    let!(:cubs_infield) { Group.create!(name: "Cubs", members: [david, rizzo]) }
    let!(:event) { Event.create!(name: "Roadtrip", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 20), settled?: false, group: cubs_infield, total: 10.00) }

    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :bills, params: { id: david.id }
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

    it "loads a user's events into @events" do
      silence_stream(STDOUT) do
        bills = david.bills
        get :bills, params: { id: david.id }
        expect(assigns(:bills)).to match_array(bills)
      end
    end
  end


  describe "POST #new_event" do
    let!(:david) { User.create!(first_name: "David", last_name: "Ross", email: "drossgrandpa@gmail.com", password: "password") }
    let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111") }
    let!(:cubs_infield) { Group.create!(name: "Cubs", members: [david, rizzo]) }

    it "responds successfully with an HTTP 201 status code" do
      silence_stream(STDOUT) do
        NEW_EVENT_JSON[:id] = david.id
        post :new_event, params: NEW_EVENT_JSON
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(201)
        end
      end
    end

    it "creates a new user event" do
      silence_stream(STDOUT) do
        expect {post :new_event, params: NEW_EVENT_JSON}.to change {Event.all.count}.by(1)
      end
    end

    it 'returns an error for invalid params' do
      silence_stream(STDOUT) do
        post :new_event, params: {"id" => david.id, "group" => "Cubs"}
        expect(response).to have_http_status(422)
      end
    end
  end


  describe "POST #create" do

    it "responds successfully with an HTTP 201 status code" do
      silence_stream(STDOUT) do
        post :create, params: NEW_USER_JSON
        aggregate_failures "testing response" do
          assert_response :success
          expect(response).to have_http_status(201)
        end
      end
    end

    it "creates a new user" do
      silence_stream(STDOUT) do
        expect { post :create, params: NEW_USER_JSON }.to change { User.all.count }.by(1)
      end
    end

    it 'returns an error for invalid params' do
      silence_stream(STDOUT) do
        post :create, params: {"last_name" => "L","email" => "e@maillllllll.com","password" => "secret"}
        expect(response).to have_http_status(422)
      end
    end
  end
end
