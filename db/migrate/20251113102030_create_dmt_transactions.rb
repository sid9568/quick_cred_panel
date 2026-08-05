class CreateDmtTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :dmt_transactions do |t|
      t.integer :dmt_id
      t.integer :user_id
      t.string :status
      t.string :txn_id
      t.string :sender_mobile_number
      t.string :bank_name
      t.string :account_number
      t.decimal :amount
      t.integer :parent_id

      t.timestamps
    end
  end
end
