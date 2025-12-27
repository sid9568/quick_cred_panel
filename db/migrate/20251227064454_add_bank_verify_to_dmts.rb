class AddBankVerifyToDmts < ActiveRecord::Migration[7.2]
  def change
    add_column :dmts, :bank_verify_status, :boolean , default: false
  end
end
