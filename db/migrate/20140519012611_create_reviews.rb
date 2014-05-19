class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.date :open
      t.date :due

      t.timestamps
    end
  end
end
