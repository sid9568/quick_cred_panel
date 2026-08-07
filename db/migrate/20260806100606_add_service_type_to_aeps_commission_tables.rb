class AddServiceTypeToAepsCommissionTables < ActiveRecord::Migration[7.2]
  def change
    add_column :aeps_commission_slab_ranges, :service_type, :string, default: "transaction", null: false
    add_column :aeps_commission_slabs, :service_type, :string, default: "transaction", null: false

    add_index :aeps_commission_slab_ranges,
              [:scheme_id, :service_type, :min_amount, :max_amount],
              name: "idx_aeps_slab_ranges_scheme_service_amount"

    add_index :aeps_commission_slabs,
              [:scheme_id, :service_type, :to_role, :aeps_commission_slab_range_id],
              name: "idx_aeps_slabs_scheme_service_role_range"
  end
end
