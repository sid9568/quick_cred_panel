class AddFieldsToDmtTransactions < ActiveRecord::Migration[7.0]
  def change
    add_column :dmt_transactions, :fee, :decimal, precision: 10, scale: 2, default: 0
    add_column :dmt_transactions, :tid, :string
    add_column :dmt_transactions, :tds, :decimal, precision: 10, scale: 2, default: 0
    add_column :dmt_transactions, :service_tax, :decimal, precision: 10, scale: 2, default: 0
    add_column :dmt_transactions, :commission, :decimal, precision: 10, scale: 2, default: 0
    add_column :dmt_transactions, :txstatus_desc, :string
    add_column :dmt_transactions, :collectable_amount, :decimal, precision: 12, scale: 2, default: 0
  end
end