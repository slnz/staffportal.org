class AddDocumentIdToUserAssignments < ActiveRecord::Migration
  def change
    add_column :user_assignments, :document_id, :integer
  end
end
