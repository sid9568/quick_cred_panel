class AddvichleNoToTrasanactions < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :vehicle_no, :string
  end
end
