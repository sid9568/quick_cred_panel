class CreateServiceProductItems < ActiveRecord::Migration[7.2]
  def change
    create_table :service_product_items do |t|
      t.references :service_product, null: false, foreign_key: true
      t.string :name
      t.string :oprator_type
      t.string :status

      t.timestamps
    end
  end
end
