class TidyUsers < ActiveRecord::Migration
  def change
    remove_column :users, 'XP'
    remove_column :users, :admin
    remove_column :users, :bootcamp_coach_id
    remove_column :users, :currency_id
    remove_column :users, :dmpd
    remove_column :users, :stats
    remove_column :users, :pac
    remove_column :users, :ready
  end
end
