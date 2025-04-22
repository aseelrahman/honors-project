class CreateBookings < ActiveRecord::Migration[8.0]
    def change
      create_table :bookings do |t|
        t.references :client, null: false, foreign_key: { to_table: :users }
        t.references :photographer_profile, null: false, foreign_key: true
        t.references :package, null: false, foreign_key: true
        t.datetime :event_date, null: false
        t.string :event_location, null: false
        t.text :special_requests
        t.integer :status, default: 0
        
        t.timestamps
      end
    end
  end