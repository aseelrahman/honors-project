class BookingMailer < ApplicationMailer
    def new_booking_request(booking)
      @booking = booking
      @photographer = booking.photographer_profile
      @client = booking.client
      
      mail(
        to: @photographer.user.email,
        subject: "New Booking Request for #{@booking.event_date.strftime('%B %d, %Y')}"
      )
    end
    
    def booking_confirmed(booking)
      @booking = booking
      @photographer = booking.photographer_profile
      @client = booking.client
      
      mail(
        to: @client.email,
        subject: "Your Wedding Photography Booking is Confirmed!"
      )
    end
    
    def booking_cancelled(booking)
      @booking = booking
      @photographer = booking.photographer_profile
      @client = booking.client
      
      mail(
        to: [@client.email, @photographer.user.email],
        subject: "Booking Cancelled - #{@booking.event_date.strftime('%B %d, %Y')}"
      )
    end
  end