class CreateWeek5s < ActiveRecord::Migration
  def change
    create_table :week5s do |t|
      t.boolean :recite_passage_from_dmpd_prayer_sheet
      t.boolean :prayer_sheet
      t.boolean :share_call_testimony
      t.boolean :share_salvation_testimony
      t.boolean :review_non_negotiables_of_effective_mpd
      t.boolean :listen_to_attitude_message
      t.text :missionary_profile
      t.boolean :memorize_prayer_sheet_passage
      t.boolean :confirmed_coach
      t.boolean :confirmed_hr
      t.integer :user_id
      t.timestamps
    end
  end
end
