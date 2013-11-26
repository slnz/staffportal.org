class AddMpdGoalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :mpd_goal, :decimal
  end
end
