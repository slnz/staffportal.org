class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.string :name
      t.text :description
      t.integer :xp_value

      t.timestamps
    end
    add_index :achievements, :name
  end
end
