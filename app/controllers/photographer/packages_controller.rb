class Photographer::PackagesController < ApplicationController
    before_action :require_login
    before_action :require_photographer
    before_action :set_profile
    
    def index
      @packages = @profile.packages
    end
    
    def new
      @package = @profile.packages.new
    end
    
    def create
      @package = @profile.packages.new(package_params)
      
      if @package.save
        redirect_to photographer_packages_path, notice: "Package created successfully"
      else
        render :new
      end
    end
    
    def edit
      @package = @profile.packages.find(params[:id])
    end
    
    def update
      @package = @profile.packages.find(params[:id])
      
      if @package.update(package_params)
        redirect_to photographer_packages_path, notice: "Package updated successfully"
      else
        render :edit
      end
    end
    
    def destroy
      @package = @profile.packages.find(params[:id])
      @package.update(active: false)
      redirect_to photographer_packages_path, notice: "Package deactivated"
    end
    
    private
    
    def set_profile
      @profile = current_user.photographer_profile
    end
    
    def package_params
      params.require(:package).permit(:name, :description, :price, 
                                     :duration_hours, :active, included_services: [])
    end
  end