class Week6 < ActiveRecord::Base
  attr_accessible :call_testimony, :discipleship_story_1, :discipleship_story_2, :discipleship_story_3, :listen_to_attitude_message, :memorize_prayer_sheet_passage, :picture_of_you_1, :picture_of_you_2, :prayer_sheet, :review_how_to_get_contacts_faster_than_you_can_use_them, :review_purpose_of_dmpd_training, :salvation_testimony, :share_call_testimony, :share_salvation_testimony, :victory_story_1, :victory_story_2
  has_one :user
end
