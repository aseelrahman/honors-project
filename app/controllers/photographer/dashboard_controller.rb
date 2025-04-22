class Photographer::DashboardController < ApplicationController
    before_action :require_login
    before_action :require_photographer
    
    def index
      @profile = current_user.photographer_profile
      @upcoming_bookings = @profile.bookings.confirmed.where('event_date > ?', Time.current)
      @recent_reviews = @profile.reviews.order(created_at: :desc).limit(5)
    end
  end