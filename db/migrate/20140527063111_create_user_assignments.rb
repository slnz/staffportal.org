class CreateUserAssignments < ActiveRecord::Migration
  def change
    create_table :user_assignments do |t|
      t.integer :assignment_id
      t.integer :user_id
      t.text :answer_text
      t.boolean :answer_boolean

      t.timestamps
    end

    add_attachment :user_assignments, :answer_upload
  end
end
