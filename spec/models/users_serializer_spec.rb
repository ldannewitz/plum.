# require 'rails_helper'
#
# RSpec.describe UserSerializer, :type => :serializer do
#
#   context 'Individual Resource Representation' do
#     let(:resource) { build(:user) }
#
#     let(:serializer) { UserSerializer.new(resource) }
#     let(:serialization) { ActiveModel::Serializer::Adapter.create(serializer) }
#
#     subject do
#       # I'm using a JSONAPI adapter, which means my profile is wrapped in a
#       # top level `profiles` object.
#       JSON.parse(serialization.to_json)['users']
#     end
#
#     it 'has an id that matches #permalink' do
#       expect(subject['id']).to eql(resource.permalink)
#     end
#
#     it 'has a name' do
#       expect(subject['name']).to eql(resource.name)
#     end
#   end
# end
