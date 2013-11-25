class CreateSupportRaisingDevelopments < ActiveRecord::Migration
  def change
    create_table :support_raising_developments do |t|
      t.integer :number_of_calls_made
      t.integer :appointments_asked_for
      t.integer :appointments_setup
      t.integer :contacts_asked_for
      t.integer :user_id
      t.integer :week_id

      t.timestamps
    end
  end
end
