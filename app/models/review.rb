class Review < ApplicationRecord
    belongs_to :booking
    belongs_to :client, class_name: 'User'
    belongs_to :photographer_profile
    
    validates :rating, presence: true, inclusion: { in: 1..5 }
    validates :content, presence: true
    validates :booking_id, uniqueness: true
  end