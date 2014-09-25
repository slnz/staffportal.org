class RemoveAttachmentFromUserAssignments < ActiveRecord::Migration
  def change
    remove_attachment :user_assignments, :answer_upload
  end
end
