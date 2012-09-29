class Week6 < ActiveRecord::Base
  attr_accessible :call_testimony, :discipleship_story_1, :discipleship_story_2, :discipleship_story_3, :listen_to_attitude_message, :memorize_prayer_sheet_passage, :picture_of_you_1, :picture_of_you_2, :prayer_sheet, :review_how_to_get_contacts_faster_than_you_can_use_them, :review_purpose_of_dmpd_training, :salvation_testimony, :share_call_testimony, :share_salvation_testimony, :victory_story_1, :victory_story_2, :confirmed_coach, :confirmed_hr
  has_one :user
  def completed
    if !call_testimony.blank? and !discipleship_story_1.blank? and !discipleship_story_2.blank? and !discipleship_story_3.blank? and listen_to_attitude_message and memorize_prayer_sheet_passage and prayer_sheet and review_how_to_get_contacts_faster_than_you_can_use_them and review_purpose_of_dmpd_training and !salvation_testimony.blank? and share_call_testimony and share_salvation_testimony and !victory_story_1.blank? and !victory_story_2.blank?
      true
    else
      false
    end
  end
  def error
    if !completed and Time.now > Date.new(2012, 10, 15)
      true
    else
      false
    end
  end
end
