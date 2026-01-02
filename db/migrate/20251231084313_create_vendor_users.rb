class CreateVendorUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :vendor_users do |t|
      t.string  :full_name
      t.string  :phone_number
      t.string  :otp
      t.datetime :vendor_expiry_otp
      t.boolean :vendor_verify_status, default: false

      t.timestamps
    end

    add_index :vendor_users, :phone_number, unique: true
  end
end
