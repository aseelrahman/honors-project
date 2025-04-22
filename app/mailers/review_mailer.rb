class ReviewMailer < ApplicationMailer
    def new_review_notification(review)
      @review = review
      @photographer = review.photographer_profile
      @client = review.client
      
      mail(
        to: @photographer.user.email,
        subject: "New Review Received - #{@review.rating} Stars"
      )
    end
  end