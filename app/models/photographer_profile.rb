class PhotographerProfile < ApplicationRecord
    belongs_to :user
    has_many :packages, dependent: :destroy
    has_many :bookings, dependent: :destroy
    has_many_attached :portfolio_images
    
    validates :business_name, :description, :experience_years, presence: true
    validates :hourly_rate, numericality: { greater_than: 0 }
  end