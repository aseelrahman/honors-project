class PaymentMailer < ApplicationMailer
    def payment_confirmation(payment)
      @payment = payment
      @booking = payment.booking
      @client = @booking.client
      @photographer = @booking.photographer_profile
      
      mail(
        to: @client.email,
        subject: "Payment Confirmation - Wedding Photography Booking"
      )
    end
    
    def photographer_payment_notification(payment)
      @payment = payment
      @booking = payment.booking
      @photographer = @booking.photographer_profile
      
      mail(
        to: @photographer.user.email,
        subject: "Payment Received - New Booking Confirmed"
      )
    end
  end