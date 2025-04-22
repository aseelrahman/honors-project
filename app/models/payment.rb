class Payment < ApplicationRecord
    belongs_to :booking
    
    enum status: { pending: 0, completed: 1, failed: 2, refunded: 3 }
    
    validates :amount, :status, presence: true
    validates :amount, numericality: { greater_than: 0 }
  end