class CreateGmaMemberships < ActiveRecord::Migration
  def change
    create_table :gma_memberships do |t|
      t.integer :user_id
      t.integer :gma_organization_id
      t.boolean :director, default: false

      t.timestamps
    end


    add_index :gma_memberships, [:user_id, :gma_organization_id], unique: true
  end
end
