class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :type_id
      t.integer :account_id
      t.decimal :amount
      t.timestamps
    end

    add_index :goals, [:type_id, :account_id], :unique => true
  end
end
