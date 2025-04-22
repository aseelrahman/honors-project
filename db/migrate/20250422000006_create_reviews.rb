class CreateReviews < ActiveRecord::Migration[8.0]
    def change
      create_table :reviews do |t|
        t.references :booking, null: false, foreign_key: true
        t.references :client, null: false, foreign_key: { to_table: :users }
        t.references :photographer_profile, null: false, foreign_key: true
        t.integer :rating, null: false
        t.text :content
        
        t.timestamps
      end
      
      add_index :reviews, :booking_id, unique: true
    end
  end