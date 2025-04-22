# app/models/concerns/reviewable.rb
module Reviewable
    extend ActiveSupport::Concern
    
    included do
      has_many :reviews, as: :reviewable, dependent: :destroy
    end
    
    def average_rating
      reviews.average(:rating).to_f.round(1)
    end
    
    def rating_count
      reviews.count
    end
  end