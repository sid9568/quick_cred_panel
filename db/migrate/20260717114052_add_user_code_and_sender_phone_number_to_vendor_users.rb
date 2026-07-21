class AddUserCodeAndSenderPhoneNumberToVendorUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :vendor_users, :user_code, :string
    add_column :vendor_users, :sender_phone_number, :string
  end
end
