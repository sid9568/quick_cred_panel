class AddVendorIdToDmts < ActiveRecord::Migration[7.2]
  def change
    add_column :dmts, :vendor_id, :integer
    add_index  :dmts, :vendor_id
  end
end
