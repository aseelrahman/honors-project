
# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:role) }
    it { should have_secure_password }
  end
  
  describe 'associations' do
    it { should have_many(:bookings_as_client) }
    it { should have_one(:photographer_profile) }
  end
  
  describe 'enums' do
    it { should define_enum_for(:role).with_values(client: 0, photographer: 1, admin: 2) }
  end
end