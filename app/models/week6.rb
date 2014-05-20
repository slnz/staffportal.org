class Week6 < ActiveRecord::Base
  attr_accessible :call_testimony, :discipleship_story_1, :discipleship_story_2,
                  :discipleship_story_3, :listen_to_attitude_message,
                  :memorize_prayer_sheet_passage, :picture_of_you_1,
                  :picture_of_you_2, :prayer_sheet,
                  :review_how_to_get_contacts_faster_than_you_can_use_them,
                  :review_purpose_of_dmpd_training, :salvation_testimony,
                  :share_call_testimony, :share_salvation_testimony,
                  :victory_story_1, :victory_story_2,
                  :confirmed_coach, :confirmed_hr, :user_id
  belongs_to :user

  COMPLETE = 'complete'
  IN_PROGRESS = 'in_progress'

  def self.finish_date
    Date.new(2013, 10, 6)
  end

  def username
    user.name unless user.nil?
  end

  def completed
    if self.completed?
      COMPLETE
    else
      IN_PROGRESS
    end
  end

  def completed?
    tasks_remaining == 0 && assignments_remaining == 0
  end

  def error
    if !completed? && Time.now > Week6.finish_date
      true
    else
      false
    end
  end

  def tasks_remaining!
    tasks_remaining > 0
  end

  def tasks_remaining
    count = 0
    count += 1 unless listen_to_attitude_message
    count += 1 unless memorize_prayer_sheet_passage
    count += 1 unless prayer_sheet
    count += 1 unless review_how_to_get_contacts_faster_than_you_can_use_them
    count += 1 unless share_call_testimony
    count += 1 unless share_salvation_testimony
    count
  end

  def assignments_remaining!
    assignments_remaining > 0
  end

  def assignments_remaining
    count = 0
    count += 1 unless !call_testimony.blank?
    count += 1 unless !discipleship_story_1.blank?
    count += 1 unless !discipleship_story_2.blank?
    count += 1 unless !discipleship_story_3.blank?
    count += 1 unless !salvation_testimony.blank?
    count += 1 unless !victory_story_1.blank?
    count += 1 unless !victory_story_2.blank?
    count
  end
end
