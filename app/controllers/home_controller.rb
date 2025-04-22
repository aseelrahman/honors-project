class HomeController < ApplicationController
    def index
      @featured_photographers = PhotographerProfile.joins(:packages)
                                                  .where(available: true)
                                                  .distinct
                                                  .limit(6)
    end
  end