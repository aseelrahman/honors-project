class CreatePhotographerProfiles < ActiveRecord::Migration[8.0]
    def change
      create_table :photographer_profiles do |t|
        t.references :user, null: false, foreign_key: true
        t.string :business_name, null: false
        t.text :description
        t.integer :experience_years
        t.decimal :hourly_rate, precision: 8, scale: 2
        t.string :location
        t.boolean :available, default: true
        
        t.timestamps
      end
    end
  end