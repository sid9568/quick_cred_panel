class AddMpinFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :set_mpin, :string
    add_column :users, :status_mpin, :boolean
  end
end
