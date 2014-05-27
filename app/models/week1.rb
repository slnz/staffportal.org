class Week1 < ActiveRecord::Base
  # attr_accessible :listen_to_attitude_message, :memorize_prayer_sheet_passage,
  #                 :prayer_sheet, :recite_passage_from_dmpd_prayer_sheet,
  #                 :practice_calling_blurbs, :recite_the_flow,
  #                 :review_healthy_staff_support_is_essentials,
  #                 :share_call_testimony, :share_salvation_testimony,
  #                 :confirmed_coach, :confirmed_hr, :user_id
  belongs_to :user

  COMPLETE = 'complete'
  IN_PROGRESS = 'in_progress'

  def self.finish_date
    Date.new(Time.now.year, 11, 10)
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
    !completed? && Time.now > Week1.finish_date
  end

  def tasks_remaining!
    tasks_remaining > 0
  end

  def tasks_remaining
    count = 0
    count += 1 unless listen_to_attitude_message
    count += 1 unless memorize_prayer_sheet_passage
    count += 1 unless prayer_sheet
    count += 1 unless practice_calling_blurbs
    count += 1 unless recite_passage_from_dmpd_prayer_sheet
    count += 1 unless recite_the_flow
    count += 1 unless review_healthy_staff_support_is_essentials
    count += 1 unless share_call_testimony
    count += 1 unless share_salvation_testimony
    count
  end

  def assignments_remaining!
    assignments_remaining > 0
  end

  def assignments_remaining
    count = 0
    count
  end
end
