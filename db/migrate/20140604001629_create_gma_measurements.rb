class CreateGmaMeasurements < ActiveRecord::Migration
  def change
    create_table :gma_measurements do |t|
      t.integer :gma_organization_id
      t.integer :gma_staff_report_id
      t.integer :gma_id
      t.string :name
      t.text :description
      t.decimal :value
      t.string :strategy

      t.timestamps
    end

    add_index :gma_measurements,
              [:gma_id, :gma_staff_report_id, :gma_organization_id],
              unique: true,
              name: 'gma_measurements_triple_index'
  end
end
