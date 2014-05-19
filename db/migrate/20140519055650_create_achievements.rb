class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.string :name
      t.text :description
      t.integer :xp_value

      t.timestamps
    end
    add_index :achievements, :name
    Achievement.create(name: 'speedy', description: 'Be one of the first 20 people to submit a newly opened People & Culture Review', xp_value: 30)
    Achievement.create(name: 'paperwork hero', description: 'Submit a People & Culture Review', xp_value: 20)
  end
end
