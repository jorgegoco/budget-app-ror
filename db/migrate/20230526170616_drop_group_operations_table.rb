class DropGroupOperationsTable < ActiveRecord::Migration[7.0]
  def change
    drop_table :group_operations
  end
end
