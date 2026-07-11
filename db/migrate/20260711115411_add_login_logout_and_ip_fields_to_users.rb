class AddLoginLogoutAndIpFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :login_in_time, :datetime
    add_column :users, :logout_time, :datetime
    add_column :users, :ip_city, :string
    add_column :users, :ip_location, :string
  end
end