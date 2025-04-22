# app/forms/photographer_registration_form.rb
class PhotographerRegistrationForm
    include ActiveModel::Model
    
    # User attributes
    attr_accessor :email, :password, :password_confirmation,
                  :first_name, :last_name, :phone
    
    # Photographer profile attributes
    attr_accessor :business_name, :description, :experience_years,
                  :hourly_rate, :location
    
    validates :email, :password, :business_name, presence: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, length: { minimum: 6 }
    
    def save
      return false unless valid?
      
      ActiveRecord::Base.transaction do
        user = User.create!(
          email: email,
          password: password,
          password_confirmation: password_confirmation,
          first_name: first_name,
          last_name: last_name,
          phone: phone,
          role: :photographer
        )
        
        user.create_photographer_profile!(
          business_name: business_name,
          description: description,
          experience_years: experience_years,
          hourly_rate: hourly_rate,
          location: location
        )
        
        true
      end
    rescue ActiveRecord::RecordInvalid => e
      errors.add(:base, e.message)
      false
    end
  end