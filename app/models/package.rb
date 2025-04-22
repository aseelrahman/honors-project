class Package < ApplicationRecord
    belongs_to :photographer_profile
    has_many :bookings
    
    validates :name, :description, :price, :duration_hours, presence: true
    validates :price, numericality: { greater_than: 0 }
  end