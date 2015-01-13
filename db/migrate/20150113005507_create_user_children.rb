class CreateUserChildren < ActiveRecord::Migration
  def change
    create_table :user_children do |t|
      t.string :first_name
      t.string :last_name
      t.text :dietary_requirements
      t.text :medical_requirements
      t.boolean :media_waiver
      t.text :comments
      t.integer :swimming_capability
      t.boolean :outings
      t.text :activity_limitations
      t.text :toileting_assistance
      t.date :date_of_birth
      t.integer :user_id

      t.timestamps
    end
  end
end
