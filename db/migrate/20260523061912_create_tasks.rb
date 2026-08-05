class CreateTasks < ActiveRecord::Migration[7.2]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.string :priority
      t.string :status
      t.string :task_status
      t.datetime :deadline
      t.references :user, null: false, foreign_key: true
      t.references :department, null: false, foreign_key: true
      t.integer :assigned_to
      t.text :pending_note
      t.text :approved_note
      t.text :note
      t.references :lead, null: false, foreign_key: true

      t.timestamps
    end
  end
end
