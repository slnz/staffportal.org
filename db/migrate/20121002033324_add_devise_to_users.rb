class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string, :null => false
    add_column :users, :admin, :string
    add_index :users, :username, :unique => true
  end
end
