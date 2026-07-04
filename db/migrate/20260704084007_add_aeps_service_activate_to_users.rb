class AddAepsServiceActivateToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :aeps_service_activate, :boolean, default: false, null: false
    add_column :users, :aeps_latlong, :string
  end
end