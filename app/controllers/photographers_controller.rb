class PhotographersController < ApplicationController
    def index
      @photographers = PhotographerProfile.joins(:user).where(available: true)
    end
    
    def show
      @photographer = PhotographerProfile.find(params[:id])
      @packages = @photographer.packages.where(active: true)
      @reviews = @photographer.reviews.order(created_at: :desc).limit(10)
    end
  end