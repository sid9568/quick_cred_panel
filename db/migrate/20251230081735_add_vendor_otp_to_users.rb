class AddVendorOtpToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :vendor_otp, :string
    add_column :users, :vendor_expiry_otp, :datetime
    add_column :users, :vendor_verify_status, :boolean , default: false
  end
end
