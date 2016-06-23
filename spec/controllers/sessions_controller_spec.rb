require "rails_helper"

RSpec.describe SessionsController, :type => :controller do
  describe "POST #login" do
    let!(:david) { User.create!(first_name: "David", last_name: "Ross", email: "drossgrandpa@gmail.com", password: "password") }
    let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password", phone: "1111111111") }
    let!(:cubs_infield) { Group.create!(name: "Cubs", members: [david, rizzo]) }
    let!(:event) { Event.create!(name: "Roadtrip", start_date: DateTime.new(2016, 6, 4), end_date: (Time.now + 1000000), settled?: false, group: cubs_infield, total: 10.00) }

    it "responds with an HTTP 201 status code upon succesful login" do
      silence_stream(STDOUT) do
        post :login, params: LOGIN_JSON
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(201)
        end
      end
    end

    it "creates a new session" do
      silence_stream(STDOUT) do
        expect {post :login, params: LOGIN_JSON}.to change {session[:user_id]}
      end
    end

    it "responds with an HTTP 422 status code upon unsuccesful login" do
      silence_stream(STDOUT) do
        LOGIN_JSON[:password] = 'fail'
        post :login, params: LOGIN_JSON
        aggregate_failures "testing response" do
          expect(response).not_to be_success
          expect(response).to have_http_status(422)
        end
      end
    end
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
        expect(session[:user_id]).to be_nil
      end
    end
  end
end
