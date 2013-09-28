class CreateWeek1s < ActiveRecord::Migration
  def change
    create_table :week1s do |t|
      t.boolean :prayer_sheet
      t.boolean :memorize_prayer_sheet_passage
      t.boolean :share_call_testimony
      t.boolean :share_salvation_testimony
      t.boolean :recite_passage_from_dmpd_prayer_sheet
      t.boolean :listen_to_attitude_message
      t.boolean :practice_calling_blurbs
      t.boolean :review_how_to_prepare_appt_calling_boxes
      t.boolean :practice_calling_blurbs
      t.boolean :review_healthy_staff_support_is_essentials
      t.boolean :recite_the_flow

      t.timestamps
    end
  end
end
