class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.text :additional_information
      t.text :speaker_description
      t.integer :logo_id
      t.integer :programme_id
      t.integer :venue_id
      t.integer :speaker_id
      t.integer :information_id
      t.date :start_date
      t.date :finish_date
      t.decimal :adult_cost
      t.decimal :teen_cost
      t.boolean :teens_can_attend, default: true
      t.decimal :child_cost
      t.boolean :children_can_attend, default: true
      t.string :address
      t.timestamps
    end
  end
end
