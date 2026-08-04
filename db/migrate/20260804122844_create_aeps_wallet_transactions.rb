class CreateAepsWalletTransactions < ActiveRecord::Migration[7.2]
   def change
    create_table :aeps_wallet_transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :aeps_wallet, null: false, foreign_key: true

      t.decimal :amount, precision: 15, scale: 2, null: false
      t.string :transaction_type, null: false
      t.string :reference_id
      t.text :remarks

      t.decimal :balance_before, precision: 15, scale: 2
      t.decimal :balance_after, precision: 15, scale: 2

      t.string :status, default: "success"

      t.timestamps
    end
  end
end
