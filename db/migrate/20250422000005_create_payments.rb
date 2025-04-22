class CreatePayments < ActiveRecord::Migration[8.0]
    def change
      create_table :payments do |t|
        t.references :booking, null: false, foreign_key: true
        t.decimal :amount, precision: 8, scale: 2, null: false
        t.decimal :platform_fee, precision: 8, scale: 2
        t.decimal :photographer_payout, precision: 8, scale: 2
        t.integer :status, default: 0
        t.string :stripe_payment_id
        t.string :stripe_refund_id
        
        t.timestamps
      end
    end
  end