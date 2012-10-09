class AddBootcampCoachToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :bootcamp_coach_id
    end

  end
end
