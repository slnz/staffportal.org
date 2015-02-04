class CreateXpLevels < ActiveRecord::Migration
  def change
    create_table :xp_levels do |t|
      t.integer :xp_min
      t.integer :xp_max
      t.integer :next_id
      t.string :name

      t.timestamps
    end
  end
end
