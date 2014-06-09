class CreateRoadblocks < ActiveRecord::Migration
  def change
    create_table :roadblocks do |t|
      t.string :title
      t.text :message

      t.timestamps
    end
  end
end
