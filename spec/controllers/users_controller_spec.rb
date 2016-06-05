require "rails_helper"

RSpec.describe UsersController, :type => :controller do
  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "loads all of the users into @users" do
      users = User.all
      get :index

      expect(assigns(:users)).to match_array(users)
    end

    it "should render JSON user serializer" do
      users = User.all
      # user = User.first
      get :index
      expect(response).to serialize_object(users).with(UserSerializer)
      # expect(response).to match_response_schema('users')
    end

  end
end
