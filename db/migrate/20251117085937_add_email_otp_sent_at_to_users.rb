class AddEmailOtpSentAtToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :email_otp_sent_at, :datetime
  end
end
