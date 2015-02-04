class CreateUserRegistrations < ActiveRecord::Migration
  def change
    create_table :user_registrations do |t|
      t.integer :user_id
      t.integer :event_id
      t.text :comments

      t.timestamps
    end
  end
end
