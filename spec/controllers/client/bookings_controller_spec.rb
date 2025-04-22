# spec/controllers/client/bookings_controller_spec.rb
require 'rails_helper'

RSpec.describe Client::BookingsController, type: :controller do
  let(:client) { create(:user, role: :client) }
  let(:package) { create(:package) }
  
  before do
    sign_in(client)
  end
  
  describe 'GET #index' do
    it 'assigns @bookings' do
      booking = create(:booking, client: client)
      get :index
      expect(assigns(:bookings)).to eq([booking])
    end
  end
  
  describe 'GET #new' do
    it 'assigns a new booking' do
      get :new, params: { package_id: package.id }
      expect(assigns(:booking)).to be_a_new(Booking)
    end
  end
  
  describe 'POST #create' do
    context 'with valid params' do
      let(:valid_params) do
        {
          booking: {
            package_id: package.id,
            event_date: 1.month.from_now,
            event_location: 'Wedding Venue'
          }
        }
      end
      
      it 'creates a new booking' do
        expect {
          post :create, params: valid_params
        }.to change(Booking, :count).by(1)
      end
      
      it 'redirects to payment page' do
        post :create, params: valid_params
        expect(response).to redirect_to(new_client_booking_payment_path(Booking.last))
      end
    end
  end
end