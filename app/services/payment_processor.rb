# app/services/payment_processor.rb
class PaymentProcessor
    def initialize(payment)
      @payment = payment
      @booking = payment.booking
    end
    
    def process
      ActiveRecord::Base.transaction do
        # Calculate fees
        @payment.platform_fee = @booking.platform_fee
        @payment.photographer_payout = @booking.photographer_payout
        
        # Here you would integrate with Stripe or another payment provider
        # For demo purposes, we'll simulate a successful payment
        if simulate_stripe_payment
          @payment.status = :completed
          @payment.save!
          @booking.update!(status: :confirmed)
          
          # Send notifications
          PaymentMailer.payment_confirmation(@payment).deliver_later
          PaymentMailer.booking_notification(@booking).deliver_later
          
          true
        else
          @payment.status = :failed
          @payment.save!
          false
        end
      end
    rescue => e
      Rails.logger.error("Payment processing error: #{e.message}")
      @payment.update(status: :failed)
      false
    end
    
    private
    
    def simulate_stripe_payment
      # In a real app, you'd use Stripe gem here
      # Simulating successful payment for demo
      @payment.stripe_payment_id = "ch_simulated_#{SecureRandom.hex(8)}"
      true
    end
  end