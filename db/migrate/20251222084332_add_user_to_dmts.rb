class AddUserToDmts < ActiveRecord::Migration[7.2]
  def change
    add_foreign_key :dmts, :users unless foreign_key_exists?(:dmts, :users)
    add_index :dmts, :user_id unless index_exists?(:dmts, :user_id)
  end
end
