class Client::PaymentsController < ApplicationController
    before_action :require_login
    before_action :require_client
    
    def new
      @booking = current_user.bookings_as_client.find(params[:booking_id])
      @payment = Payment.new(booking: @booking, amount: @booking.total_amount)
    end
    
    def create
      @booking = current_user.bookings_as_client.find(params[:booking_id])
      @payment = @booking.build_payment(payment_params)
      
      if @payment.process_payment
        @booking.update(status: :confirmed)
        redirect_to client_booking_path(@booking), notice: "Payment successful"
      else
        render :new
      end
    end
    
    private
    
    def payment_params
      params.require(:payment).permit(:stripe_token)
    end
  end