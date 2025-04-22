# spec/models/booking_spec.rb
require 'rails_helper'

RSpec.describe Booking, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:event_date) }
    it { should validate_presence_of(:event_location) }
    it { should validate_presence_of(:status) }
  end
  
  describe 'associations' do
    it { should belong_to(:client) }
    it { should belong_to(:photographer_profile) }
    it { should belong_to(:package) }
    it { should have_one(:payment) }
  end
  
  describe '#total_amount' do
    let(:package) { create(:package, price: 1000) }
    let(:booking) { create(:booking, package: package) }
    
    it 'returns the package price' do
      expect(booking.total_amount).to eq(1000)
    end
  end
  
  describe '#platform_fee' do
    let(:package) { create(:package, price: 1000) }
    let(:booking) { create(:booking, package: package) }
    
    it 'returns 20% of the total amount' do
      expect(booking.platform_fee).to eq(200)
    end
  end
  
  describe '#photographer_payout' do
    let(:package) { create(:package, price: 1000) }
    let(:booking) { create(:booking, package: package) }
    
    it 'returns 80% of the total amount' do
      expect(booking.photographer_payout).to eq(800)
    end
  end
end