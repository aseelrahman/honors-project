class Photographer::ProfilesController < ApplicationController
    before_action :require_login
    before_action :require_photographer
    
    def new
      @profile = PhotographerProfile.new
    end
    
    def create
      @profile = current_user.build_photographer_profile(profile_params)
      
      if @profile.save
        redirect_to photographer_dashboard_path, notice: "Profile created successfully"
      else
        render :new
      end
    end
    
    def edit
      @profile = current_user.photographer_profile
    end
    
    def update
      @profile = current_user.photographer_profile
      
      if @profile.update(profile_params)
        redirect_to photographer_dashboard_path, notice: "Profile updated successfully"
      else
        render :edit
      end
    end
    
    private
    
    def profile_params
      params.require(:photographer_profile).permit(:business_name, :description, 
                                                 :experience_years, :hourly_rate, 
                                                 :location, :available, portfolio_images: [])
    end
  end
  