class Booking < ApplicationRecord
    belongs_to :client, class_name: 'User', foreign_key: 'client_id'
    belongs_to :photographer_profile
    belongs_to :package
    has_one :payment
    
    enum status: { pending: 0, confirmed: 1, completed: 2, cancelled: 3 }
    
    validates :event_date, :event_location, presence: true
    validates :status, presence: true
    
    def total_amount
      package.price
    end
    
    def platform_fee
      total_amount * 0.2
    end
    
    def photographer_payout
      total_amount * 0.8
    end
  end