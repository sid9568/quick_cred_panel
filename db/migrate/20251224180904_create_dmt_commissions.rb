class CreateDmtCommissions < ActiveRecord::Migration[7.2]
  def change
    create_table :dmt_commissions do |t|
      t.integer :dmt_id, null: false
      t.integer :user_id, null: false
      t.string  :role
      t.decimal :commission_amount, precision: 10, scale: 4
      t.integer :service_product_item_id

      t.timestamps
    end
  end
end
