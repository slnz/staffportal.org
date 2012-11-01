class CreateTypes < ActiveRecord::Migration
  def change
    create_table :types do |t|
      t.string :name
      t.boolean :is_income

      t.timestamps
    end
  end
end
