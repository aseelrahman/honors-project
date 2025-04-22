# app/helpers/bookings_helper.rb
module BookingsHelper
    def can_cancel_booking?(booking)
      booking.pending? || (booking.confirmed? && booking.event_date > 7.days.from_now)
    end
    
    def days_until_event(booking)
      (booking.event_date.to_date - Date.current).to_i
    end
    
    def booking_cancellation_fee(booking)
      return 0 if booking.pending?
      
      days_until = days_until_event(booking)
      if days_until > 30
        0
      elsif days_until > 14
        booking.total_amount * 0.25
      elsif days_until > 7
        booking.total_amount * 0.50
      else
        booking.total_amount
      end
    end
  end