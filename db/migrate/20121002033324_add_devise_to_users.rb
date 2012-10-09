class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username, :null => false
      t.string :admin
    end
    add_index :users, :username, :unique => true
  end
end
