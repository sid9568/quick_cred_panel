class CreateAepsTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :aeps_transactions do |t|
      t.references :user, null: false, foreign_key: true

      t.string :transaction_type
      t.string :client_ref_id
      t.string :customer_id
      t.string :user_code
      t.string :bank_code
      t.string :bank_name

      t.string :aadhaar_number
      t.string :aadhaar_last4

      t.decimal :amount, precision: 12, scale: 2
      t.decimal :customer_balance, precision: 12, scale: 2
      t.decimal :opening_balance, precision: 12, scale: 2
      t.decimal :closing_balance, precision: 12, scale: 2
      t.decimal :commission, precision: 12, scale: 2
      t.decimal :tds, precision: 12, scale: 2

      t.string :tx_status
      t.string :status

      t.string :message
      t.text :comment

      t.string :tid
      t.string :bank_ref_num

      t.string :merchant_name
      t.string :sender_name
      t.string :shop_name

      t.datetime :transaction_date

      t.jsonb :provider_response

      t.timestamps
    end

    add_index :aeps_transactions, :client_ref_id
  end
end