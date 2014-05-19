class CreateXpLevels < ActiveRecord::Migration
  def change
    create_table :xp_levels do |t|
      t.integer :xp_min
      t.integer :xp_max
      t.integer :next_id
      t.string :name

      t.timestamps
    end

    xp = XpLevel.create(name: 'pro', xp_min: 100000, xp_max: 200000)
    xp = XpLevel.create(name: 'diamond', xp_min: 800, xp_max: 100000, next_id: xp.id)
    xp = XpLevel.create(name: 'ruby', xp_min: 400, xp_max: 800, next_id: xp.id)
    xp = XpLevel.create(name: 'gold', xp_min: 200, xp_max: 400, next_id: xp.id)
    xp = XpLevel.create(name: 'silver', xp_min: 100, xp_max: 200, next_id: xp.id)
    xp = XpLevel.create(name: 'bronze', xp_min: 0, xp_max: 100, next_id: xp.id)

  end
end
