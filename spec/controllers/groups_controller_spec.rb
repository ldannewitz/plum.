# require "rails_helper"
#
# RSpec.describe GroupsController, :type => :controller do
#
#   let!(:member) { User.create!(first_name: 'First', last_name: 'Last', email: 'e@mail.com', password: 'password') }
#   let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password") }
#   let (:group) { Group.new(name: "Cubs").add_members([member, rizzo], member.id) }
#
#   # describe "POST #create" do
#   #   let(:json) { NEW_GROUP_JSON }
#   #
#   #   it "responds successfully with an HTTP 204 status code" do
#   #     silence_stream(STDOUT) do
#   #       post :create, {}, json, "CONTENT_TYPE" => 'application/json'
#   #       aggregate_failures "testing response" do
#   #         expect(response).to be_success
#   #         expect(response).to have_http_status(204)
#   #       end
#   #     end
#   #   end
#   #
#   #   it "creates a new group" do
#   #     silence_stream(STDOUT) do
#   #       expect {post :create, params: json}.to change { Group.all.count }.by(1)
#   #     end
#   #   end
#   # end
#
#   describe "GET #show" do
#     # let!(:member) { User.create!(first_name: 'First', last_name: 'Last', email: 'e@mail.com', password: 'password') }
#     # let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password") }
#     # let (:group) { Group.new(name: "Cubs").add_members([member, rizzo], member.id) }
#
#     it "responds successfully with an HTTP 200 status code" do
#       silence_stream(STDOUT) do
#         get :show, params: { id: group.id }
#         aggregate_failures "testing response" do
#           expect(response).to be_success
#           expect(response).to have_http_status(200)
#         end
#       end
#     end
#
#     it "loads a group into @group" do
#       silence_stream(STDOUT) do
#         get :show, params: { id: group.id }
#         expect(assigns(:group)).to match(group)
#       end
#     end
#   end
#
#   describe "GET #members" do
#     # let!(:member) { User.create!(first_name: 'First', last_name: 'Last', email: 'e@mail.com', password: 'password') }
#     # let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password") }
#     # let (:group) { Group.new(name: "Cubs").add_members([member, rizzo], member.id) }
#
#     it "responds successfully with an HTTP 200 status code" do
#       silence_stream(STDOUT) do
#         get :members, params: { id: group.id }
#         aggregate_failures "testing response" do
#           expect(response).to be_success
#           expect(response).to have_http_status(200)
#         end
#       end
#     end
#
#     it "loads a group's members into @members" do
#       silence_stream(STDOUT) do
#         members = group.members
#         get :members, params: { id: group.id }
#         expect(assigns(:members)).to match_array(members)
#       end
#     end
#   end
#
#   describe "GET #events" do
#     # let!(:member) { User.create!(first_name: 'First', last_name: 'Last', email: 'e@mail.com', password: 'password') }
#     # let!(:rizzo) { User.create!(first_name: "Anthony", last_name: "Rizzo", email: "arizzo@gmail.com", password: "password") }
#     # let (:group) { Group.new(name: "Cubs").add_members([member, rizzo], member.id) }
#
#     it "responds successfully with an HTTP 200 status code" do
#       silence_stream(STDOUT) do
#         get :events, params: { id: group.id }
#         aggregate_failures "testing response" do
#           expect(response).to be_success
#           expect(response).to have_http_status(200)
#         end
#       end
#     end
#
#     it "loads a group's events into @events" do
#       silence_stream(STDOUT) do
#         events = group.events
#         get :events, params: { id: group.id }
#         expect(assigns(:events)).to match_array(events)
#       end
#     end
#   end
# end
