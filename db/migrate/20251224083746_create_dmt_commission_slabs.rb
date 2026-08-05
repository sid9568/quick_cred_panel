class CreateDmtCommissionSlabs < ActiveRecord::Migration[7.2]
  def change
    create_table :dmt_commission_slabs do |t|
      # 🔹 AMOUNT RANGE
      t.decimal :min_amount, precision: 10, scale: 2
      t.decimal :max_amount, precision: 10, scale: 2

      # 🔹 FEES
      t.decimal :bank_fee_percent, precision: 5, scale: 2, default: 1.0
      t.decimal :eko_fee, precision: 10, scale: 2, default: 7.0
      t.decimal :surcharge, precision: 10, scale: 2, default: 0.0
      t.decimal :tds_percent, precision: 5, scale: 2, default: 2.0
      t.decimal :gst_percent, precision: 5, scale: 2, default: 2.0

      # 🔹 COMMISSION FLOW
      t.string  :from_role   # admin / distributor / retailer
      t.string  :to_role
      t.decimal :value, precision: 10, scale: 2

      # 🔹 STATUS
      t.boolean :active, default: true

      # 🔹 SCHEME
      t.references :scheme, foreign_key: true, index: true

      t.timestamps
    end

    add_index :dmt_commission_slabs, [:min_amount, :max_amount]
  end
end
