class AddAddharKycStatusToVendorUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :vendor_users, :addhar_kyc_status, :boolean
  end
end
