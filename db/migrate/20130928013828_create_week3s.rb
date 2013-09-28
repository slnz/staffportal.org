class CreateWeek3s < ActiveRecord::Migration
  def change
    create_table :week3s do |t|
      t.boolean :prayer_sheet
      t.boolean :memorize_prayer_sheet_passage
      t.boolean :share_call_testimony
      t.boolean :share_salvation_testimony
      t.boolean :recite_passage_from_dmpd_prayer_sheet
      t.boolean :listen_to_attitude_message
      t.boolean :review_how_to_develop_your_ministry_partners
      t.boolean :practice_tandems_financial_policy
      t.string :practice_our_teams_current_financial_needs

      t.timestamps
    end
  end
end
