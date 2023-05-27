class AddForeignKeyToOperations < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :operations, :groups
  end
end
