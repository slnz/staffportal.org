class CreateWeek4s < ActiveRecord::Migration
  def change
    create_table :week4s do |t|
      t.boolean :prayer_sheet
      t.boolean :memorize_prayer_sheet_passage
      t.boolean :share_call_testimony
      t.boolean :share_salvation_testimony
      t.boolean :recite_passage_from_dmpd_prayer_sheet
      t.boolean :listen_to_attitude_message
      t.boolean :review_the_five_main_things

      t.timestamps
    end
  end
end
