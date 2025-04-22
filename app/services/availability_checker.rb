# app/services/availability_checker.rb
class AvailabilityChecker
    def initialize(photographer_profile)
      @photographer_profile = photographer_profile
    end
    
    def available_on?(date)
      # Check if photographer has any confirmed bookings on this date
      !@photographer_profile.bookings
                           .confirmed
                           .where(event_date: date.beginning_of_day..date.end_of_day)
                           .exists?
    end
    
    def available_dates_in_range(start_date, end_date)
      dates = []
      (start_date..end_date).each do |date|
        dates << date if available_on?(date)
      end
      dates
    end
  end