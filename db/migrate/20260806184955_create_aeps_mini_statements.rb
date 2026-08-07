class CreateAepsMiniStatements < ActiveRecord::Migration[7.2]
  def change
    create_table :aeps_mini_statements do |t|
      t.references :user, null: false, foreign_key: true
      t.string :bank_code
      t.string :customer_id
      t.string :aadhaar_last4
      t.string :status
      t.jsonb :commission_data
      t.jsonb :provider_response

      t.timestamps
    end
  end
end
