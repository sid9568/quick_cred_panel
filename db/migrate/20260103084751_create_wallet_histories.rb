class CreateWalletHistories < ActiveRecord::Migration[7.2]
  def change
    create_table :wallet_histories do |t|
      t.references :wallet, null: false, foreign_key: true
      t.integer :user_id
      t.integer :parent_id

      t.decimal :amount, precision: 15, scale: 2   # + / -
      t.decimal :before_balance, precision: 15, scale: 2
      t.decimal :after_balance, precision: 15, scale: 2

      t.string :transaction_type   # credit / debit
      t.string :remark              # recharge, dmt, commission, refund
      t.string :reference_id        # txn_id / order_id

      t.timestamps
    end
  end
end
