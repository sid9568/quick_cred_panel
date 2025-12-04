class FixCommissionColumns < ActiveRecord::Migration[7.0]
  def change
    # Safely remove old columns (only if they exist)
    remove_column :commissions, :admin_value, :decimal, if_exists: true
    remove_column :commissions, :master_value, :decimal, if_exists: true
    remove_column :commissions, :dealer_value, :decimal, if_exists: true
    remove_column :commissions, :retailer_value, :decimal, if_exists: true

    # Add new correct columns (only if they don't exist)
    add_column :commissions, :set_by_role, :string unless column_exists?(:commissions, :set_by_role)
    add_column :commissions, :set_for_role, :string unless column_exists?(:commissions, :set_for_role)
    add_column :commissions, :value, :decimal, precision: 10, scale: 2 unless column_exists?(:commissions, :value)
  end
end
