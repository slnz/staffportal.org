class CreateGmaOrganizations < ActiveRecord::Migration
  def change
    create_table :gma_organizations do |t|
      t.integer :gma_id
      t.string :name

      t.timestamps
    end

    add_index :gma_organizations, :gma_id
  end
end
