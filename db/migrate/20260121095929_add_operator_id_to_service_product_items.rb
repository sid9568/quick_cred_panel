class AddOperatorIdToServiceProductItems < ActiveRecord::Migration[7.2]
  def change
    add_column :service_product_items, :operator_id, :bigint
    add_index  :service_product_items, :operator_id
    add_column :commissions, :commission_rate, :string
  end
end
