class AddBankCodeToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :bank_code, :string
  end
end
