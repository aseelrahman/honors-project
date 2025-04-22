class Client::BookingsController < ApplicationController
    before_action :require_login
    before_action :require_client
    
    def index
      @bookings = current_user.bookings_as_client.includes(:photographer_profile, :package)
    end
    
    def new
      @package = Package.find(params[:package_id])
      @booking = Booking.new(package: @package, photographer_profile: @package.photographer_profile)
    end
    
    def create
      @booking = current_user.bookings_as_client.new(booking_params)
      
      if @booking.save
        redirect_to new_client_booking_payment_path(@booking), notice: "Booking created successfully"
      else
        @package = @booking.package
        render :new
      end
    end
    
    def show
      @booking = current_user.bookings_as_client.find(params[:id])
    end
    
    private
    
    def booking_params
      params.require(:booking).permit(:photographer_profile_id, :package_id, 
                                     :event_date, :event_location, :special_requests)
    end
  end