require_relative '../rails_helper'

RSpec.describe Membership, type: :model do

  it 'belongs to a member' do
    should { belong_to(:member) }
  end

  it 'belongs to a group' do
    should { belong_to(:group) }
  end

end
