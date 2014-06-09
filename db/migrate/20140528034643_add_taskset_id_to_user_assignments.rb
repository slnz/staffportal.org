class AddTasksetIdToUserAssignments < ActiveRecord::Migration
  def change
    add_column :user_assignments, :taskset_id, :integer
    add_index :user_assignments, :taskset_id
  end
end
