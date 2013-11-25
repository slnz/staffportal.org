class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.date :date_start
      t.date :date_finished

      t.timestamps
    end
  end
end
