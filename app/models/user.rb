class User < ApplicationRecord
    has_secure_password
    
    has_many :bookings_as_client, class_name: 'Booking', foreign_key: 'client_id'
    has_one :photographer_profile, dependent: :destroy
    
    enum role: { client: 0, photographer: 1, admin: 2 }
    
    validates :email, presence: true, uniqueness: true
    validates :role, presence: true
  end