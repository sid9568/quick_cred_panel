class ChangeVendorIdToVendorUserInDmts < ActiveRecord::Migration[7.2]
  def change
    # ❌ remove old column
    remove_column :dmts, :vendor_id, :integer

    # ✅ add proper reference
    add_reference :dmts, :vendor_user, foreign_key: true

  end
end
