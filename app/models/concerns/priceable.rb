# app/models/concerns/priceable.rb
module Priceable
    extend ActiveSupport::Concern
    
    included do
      validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
    end
    
    def formatted_price
      sprintf("$%.2f", price)
    end
    
    def price_in_cents
      (price * 100).to_i
    end
  end