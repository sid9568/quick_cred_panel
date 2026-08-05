class AddDefaultToAddharKycStatusInVendorUsers < ActiveRecord::Migration[7.2]
  def up
    change_column_default :vendor_users, :addhar_kyc_status, false
    VendorUser.where(addhar_kyc_status: nil).update_all(addhar_kyc_status: false)
  end

  def down
    change_column_default :vendor_users, :addhar_kyc_status, nil
  end
end
