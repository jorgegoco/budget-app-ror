class AddGroupIdToOperations < ActiveRecord::Migration[7.0]
  def change
    add_column :operations, :group_id, :bigint
    add_index :operations, :group_id
  end
end
