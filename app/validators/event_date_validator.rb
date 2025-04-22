# app/validators/event_date_validator.rb
class EventDateValidator < ActiveModel::Validator
    def validate(record)
      if record.event_date.present? && record.event_date < 3.days.from_now
        record.errors.add(:event_date, "must be at least 3 days from now")
      end
    end
  end