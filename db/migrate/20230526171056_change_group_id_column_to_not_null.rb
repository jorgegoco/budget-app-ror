class ChangeGroupIdColumnToNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column :operations, :group_id, :bigint, null: false
  end
end
