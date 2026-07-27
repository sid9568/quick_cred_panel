class CreateAepsWallets < ActiveRecord::Migration[7.2]
  def change
    create_table :aeps_wallets do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :balance, precision: 15, scale: 2, default: 0.0, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
