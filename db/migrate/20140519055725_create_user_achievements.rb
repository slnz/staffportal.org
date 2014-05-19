class CreateUserAchievements < ActiveRecord::Migration
  def change
    create_table :user_achievements do |t|
      t.integer :user_id
      t.integer :achievement_id
      t.integer :count, default: 0

      t.timestamps
    end
    add_index :user_achievements, :user_id
    add_index :user_achievements, :achievement_id
  end
end
