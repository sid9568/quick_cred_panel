class AddTxnIdToDmts < ActiveRecord::Migration[7.2]
  def change
    add_column :dmts, :txn_id, :string
    add_column :dmts, :transaction_status, :boolean, default: false
  end
end
