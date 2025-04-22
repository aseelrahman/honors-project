# app/helpers/photographers_helper.rb
module PhotographersHelper
    def photographer_experience_badge(years)
      badge_text = case years
                   when 0..2 then "New Photographer"
                   when 3..5 then "Experienced"
                   when 6..10 then "Very Experienced"
                   else "Master Photographer"
                   end
      
      content_tag(:span, badge_text, class: 'experience-badge')
    end
    
    def photographer_rating_summary(photographer)
      if photographer.reviews.any?
        "#{photographer.average_rating} ★ (#{pluralize(photographer.rating_count, 'review')})"
      else
        "No reviews yet"
      end
    end
  end