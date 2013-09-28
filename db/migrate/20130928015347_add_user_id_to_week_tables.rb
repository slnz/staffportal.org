class AddUserIdToWeekTables < ActiveRecord::Migration
  def change
  	add_column :week4s, :user_id, :integer
  	add_column :week3s, :user_id, :integer
  	add_column :week2s, :user_id, :integer
  	add_column :week1s, :user_id, :integer

  	add_column :week4s, :confirmed_coach, :boolean
  	add_column :week3s, :confirmed_coach, :boolean
  	add_column :week2s, :confirmed_coach, :boolean
  	add_column :week1s, :confirmed_coach, :boolean

  	add_column :week4s, :confirmed_hr, :boolean
  	add_column :week3s, :confirmed_hr, :boolean
  	add_column :week2s, :confirmed_hr, :boolean
  	add_column :week1s, :confirmed_hr, :boolean
  end
end
