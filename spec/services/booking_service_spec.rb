# spec/services/booking_service_spec.rb
require 'rails_helper'

RSpec.describe BookingService do
  describe '.create_booking' do
    let(:client) { create(:user, role: :client) }
    let(:package) { create(:package) }
    let(:booking_params) do
      {
        event_date: 1.month.from_now,
        event_location: 'Wedding Venue',
        special_requests: 'Extra photos'
      }
    end
    
    context 'when booking creation is successful' do
      it 'creates a booking' do
        expect {
          described_class.create_booking(client: client, package: package, booking_params: booking_params)
        }.to change(Booking, :count).by(1)
      end
      
      it 'creates a pending payment' do
        expect {
          described_class.create_booking(client: client, package: package, booking_params: booking_params)
        }.to change(Payment, :count).by(1)
      end
      
      it 'returns success with the booking' do
        result = described_class.create_booking(client: client, package: package, booking_params: booking_params)
        expect(result[:success]).to be true
        expect(result[:booking]).to be_a(Booking)
      end
    end
    
    context 'when booking creation fails' do
      let(:invalid_params) { { event_date: nil } }
      
      it 'returns failure with errors' do
        result = described_class.create_booking(client: client, package: package, booking_params: invalid_params)
        expect(result[:success]).to be false
        expect(result[:errors]).to be_present
      end
    end
  end
end