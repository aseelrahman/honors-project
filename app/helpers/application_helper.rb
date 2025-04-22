# app/helpers/application_helper.rb
module ApplicationHelper
    def format_price(amount)
      number_to_currency(amount, precision: 0)
    end
    
    def format_date(date)
      date.strftime("%B %d, %Y")
    end
    
    def booking_status_badge(status)
      badge_class = case status.to_sym
                    when :pending then 'badge-warning'
                    when :confirmed then 'badge-success'
                    when :completed then 'badge-info'
                    when :cancelled then 'badge-danger'
                    else 'badge-secondary'
                    end
      
      content_tag(:span, status.titleize, class: "badge #{badge_class}")
    end
    
    def rating_stars(rating)
      full_stars = rating.to_i
      half_star = (rating - full_stars) >= 0.5 ? 1 : 0
      empty_stars = 5 - full_stars - half_star
      
      stars_html = '★' * full_stars
      stars_html += '½' if half_star == 1
      stars_html += '☆' * empty_stars
      
      content_tag(:span, stars_html, class: 'rating-stars')
    end
  end