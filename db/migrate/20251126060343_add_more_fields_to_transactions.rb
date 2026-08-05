class AddMoreFieldsToTransactions < ActiveRecord::Migration[7.2]
  def change
    add_column :transactions, :tid, :string
    add_column :transactions, :tds, :decimal
    add_column :transactions, :sender_id, :string
    add_column :transactions, :payment_mode_desc, :string
    add_column :transactions, :totalamount, :decimal
    add_column :transactions, :status_text, :string
    add_column :transactions, :txstatus_desc, :string
    add_column :transactions, :commission, :string
    add_column :transactions, :mobile, :string
  end
end
