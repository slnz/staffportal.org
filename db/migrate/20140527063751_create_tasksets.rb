class CreateTasksets < ActiveRecord::Migration
  def change
    create_table :tasksets do |t|
      t.string :name
      t.integer :due_week

      t.timestamps
    end
  end
end
