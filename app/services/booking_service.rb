class BookingService
    def self.create_booking(client:, package:, booking_params:)
      booking = Booking.new(booking_params)
      booking.client = client
      booking.package = package
      booking.photographer_profile = package.photographer_profile
      
      ActiveRecord::Base.transaction do
        if booking.save
          # Create pending payment
          payment = booking.create_payment!(
            amount: booking.total_amount,
            status: :pending
          )
          
          # Notify photographer about new booking
          BookingMailer.new_booking_request(booking).deliver_later
          
          { success: true, booking: booking }
        else
          { success: false, errors: booking.errors }
        end
      end
    rescue => e
      Rails.logger.error("Booking creation failed: #{e.message}")
      { success: false, errors: ["An error occurred while creating the booking"] }
    end
    
    def self.cancel_booking(booking)
      return false unless booking.can_be_cancelled?
      
      ActiveRecord::Base.transaction do
        booking.update!(status: :cancelled)
        
        # Process refund if payment was completed
        if booking.payment&.completed?
          refund_payment(booking.payment)
        end
        
        # Notify parties
        BookingMailer.booking_cancelled(booking).deliver_later
        
        true
      end
    rescue => e
      Rails.logger.error("Booking cancellation failed: #{e.message}")
      false
    end
    
    private
    
    def self.refund_payment(payment)
      # Here you would integrate with Stripe to process the refund
      payment.update!(
        status: :refunded,
        stripe_refund_id: "re_simulated_#{SecureRandom.hex(8)}"
      )
    end
  end