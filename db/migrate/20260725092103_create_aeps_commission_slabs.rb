class CreateAepsCommissionSlabs < ActiveRecord::Migration[7.2]
  def change
    create_table :aeps_commission_slabs do |t|
      t.decimal :min_amount
      t.decimal :max_amount
      t.decimal :bank_fee_percent
      t.decimal :eko_fee
      t.decimal :surcharge
      t.decimal :tds_percent
      t.decimal :gst_percent
      t.string :from_role
      t.string :to_role
      t.decimal :value
      t.boolean :active
      t.integer :scheme_id
      t.integer :aeps_commission_slab_range_id

      t.timestamps
    end
  end
end
