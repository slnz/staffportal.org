class AddComponentsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dmpd, :boolean, default: false
    add_column :users, :stats, :boolean, default: false
    add_column :users, :pac, :boolean, default: false
  end
end
