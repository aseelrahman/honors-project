class CreatePackages < ActiveRecord::Migration[8.0]
    def change
      create_table :packages do |t|
        t.references :photographer_profile, null: false, foreign_key: true
        t.string :name, null: false
        t.text :description
        t.decimal :price, precision: 8, scale: 2, null: false
        t.integer :duration_hours
        t.text :included_services, array: true, default: []
        t.boolean :active, default: true
        
        t.timestamps
      end
    end
  end