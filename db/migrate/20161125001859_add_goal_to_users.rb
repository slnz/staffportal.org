class AddGoalToUsers < ActiveRecord::Migration
  def change
    remove_column :users, :mpd_goal, :integer
    add_column :users, :goal, :integer
  end
end
