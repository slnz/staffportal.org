class CreateWeek6s < ActiveRecord::Migration
  def change
    create_table :week6s do |t|
      t.integer :user_id
      t.boolean :prayer_sheet
      t.text :salvation_testimony
      t.boolean :share_salvation_testimony
      t.text :call_testimony
      t.boolean :share_call_testimony
      t.boolean :review_purpose_of_dmpd_training
      t.boolean :review_how_to_get_contacts_faster_than_you_can_use_them
      t.boolean :listen_to_attitude_message
      t.text :discipleship_story_1
      t.text :discipleship_story_2
      t.text :discipleship_story_3
      t.text :victory_story_1
      t.text :victory_story_2
      t.boolean :memorize_prayer_sheet_passage
      t.column :picture_of_you_1, :bytea
      t.column :picture_of_you_2, :bytea
      t.timestamps
    end
  end
end
