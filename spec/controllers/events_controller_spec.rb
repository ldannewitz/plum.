require "rails_helper"

RSpec.describe EventsController, :type => :controller do

  before(:each) do
    @member = User.create!(first_name: 'First', last_name: 'Last', email: 'e@mail.com', password: 'password')
    @rizzo = User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password")
    @cubs_infield = Group.new(name: "Cubs", members: [@member, @rizzo])
    @event = Event.create!(name: "Roadtrip", start_date: DateTime.new(2016, 6, 4), end_date: DateTime.new(2016, 6, 6), settled?: false, group: @cubs_infield)
  end

  describe "GET #show" do


    it "responds successfully with an HTTP 200 status code" do
      silence_stream(STDOUT) do
        get :show, params: { id: @event.id }
        aggregate_failures "testing response" do
          expect(response).to be_success
          expect(response).to have_http_status(200)
        end
      end
    end

    it "loads an event into @event" do
      silence_stream(STDOUT) do
        get :show, params: { id: @event.id }
        expect(assigns(:event)).to match(@event)
      end
    end
  end

  describe "POST #new_expense" do

    # it "responds successfully with an HTTP 201 status code" do
    #   # silence_stream(STDOUT) do
    #     NEW_EXPENSE_JSON["id"] = @event.id
    #     NEW_EXPENSE_JSON["event_id"] = @event.id
    #     NEW_EXPENSE_JSON["spender_id"] = @rizzo.id
    #     post :new_expense, params: NEW_EXPENSE_JSON
    #     aggregate_failures "testing response" do
    #       # assert_response :success
    #       expect(response).to be_success
    #       expect(response).to have_http_status(201)
    #     end
    #   # end
    # end
    #
    # it "creates a new expense" do
    #   # silence_stream(STDOUT) do
    #     expect { post :new_expense, params: NEW_EXPENSE_JSON }.to change { Expense.all.count }.by(1)
    #   # end
    # end

    it 'returns an error for invalid params' do
      silence_stream(STDOUT) do
        post :new_expense, params: {"location"=>"Des Moines", "id"=>"1"}
        expect(response).to have_http_status(422)
      end
    end
  end
end
