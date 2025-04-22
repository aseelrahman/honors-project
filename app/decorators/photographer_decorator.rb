# app/decorators/photographer_decorator.rb
class PhotographerDecorator < SimpleDelegator
    def initialize(photographer_profile)
      @photographer_profile = photographer_profile
      super(@photographer_profile)
    end
    
    def full_name
      user = @photographer_profile.user
      if user.first_name.present? && user.last_name.present?
        "#{user.first_name} #{user.last_name}"
      else
        business_name
      end
    end
    
    def display_experience
      "#{experience_years} #{experience_years == 1 ? 'year' : 'years'} of experience"
    end
    
    def price_range
      return "Contact for pricing" if packages.empty?
      
      min_price = packages.minimum(:price)
      max_price = packages.maximum(:price)
      
      if min_price == max_price
        "Starting at #{format_price(min_price)}"
      else
        "#{format_price(min_price)} - #{format_price(max_price)}"
      end
    end
    
    private
    
    def format_price(amount)
      "$#{amount.to_i}"
    end
  end