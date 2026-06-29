class AddAepsKycAndDailyKycToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :aeps_kyc, :boolean, default: false, null: false
    add_column :users, :daily_aeps_kyc, :boolean, default: false, null: false
  end
end