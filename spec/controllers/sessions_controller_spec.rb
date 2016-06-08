require "rails_helper"

RSpec.describe SessionsController, :type => :controller do
  describe "POST #login" do
    #   it "responds successfully with an HTTP 204 status code" do
    #     silence_stream(STDOUT) do
    #       post :login, params: json
    #       aggregate_failures "testing response" do
    #         expect(response).to be_success
    #         expect(response).to have_http_status(204)
    #       end
    #     end
    #   end
    #
    #   # it "creates a new session" do
    #   #   expect {post :login, params: json}.to change {session[:user_id]}
    #   # end
  end

  describe "GET #logout" do

    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :logout
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(204)
        end
      end
    end

    it "clears the user session" do
      silence_stream(STDOUT) do
        get :logout
        expect(session[:user_id]).to be(nil)
      end
    end
  end
end
