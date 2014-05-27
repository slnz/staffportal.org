class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.string :description
      t.integer :kind
      t.integer :taskset_id

      t.timestamps
    end
  end
end
