class CreateCibilReports < ActiveRecord::Migration[7.2]
  def change
    create_table :cibil_reports do |t|
      t.references :user, null: false, foreign_key: true
      t.string :pan
      t.string :mobile_number
      t.string :name
      t.string :credit_score
      t.string :bureau
      t.jsonb :response_data
      t.string :doc_id
      t.integer :status_code
      t.boolean :success

      t.timestamps
    end
  end
end
