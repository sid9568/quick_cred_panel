class CreateDmts < ActiveRecord::Migration[7.2]
  def change
    create_table :dmts do |t|
      t.string :account_number
      t.string :confirm_account_number
      t.string :sender_mobile_number
      t.string :receiver_name
      t.string :receiver_mobile_number
      t.string :sender_full_name
      t.string :bank_name
      t.string :ifsc_code
      t.string :branch_name
      t.decimal :amount
      t.integer :parent_id
      t.integer :user_id
      t.boolean :beneficiaries_status
      t.string :status
      t.string :aadhaar_number_otp
      t.datetime :aadhaar_number_otp_expiry

      t.timestamps
    end
  end
end
