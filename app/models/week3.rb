class Week3 < ActiveRecord::Base
  attr_accessible :listen_to_attitude_message, :memorize_prayer_sheet_passage, :practice_our_teams_current_financial_needs, :practice_tandems_financial_policy, :prayer_sheet, :recite_passage_from_dmpd_prayer_sheet, :review_how_to_develop_your_ministry_partners, :share_call_testimony, :share_salvation_testimony, :confirmed_coach, :confirmed_hr, :user_id, :vision_folder
  belongs_to :user

  has_attached_file :vision_folder

  validates_attachment :vision_folder,
  :size => { :in => 0..5.megabytes }

  COMPLETE = "complete"
  IN_PROGRESS = "in_progress"

  def self.finish_date
    Date.new(2013, 10, 28)
  end

  def username
    self.user.name unless self.user.nil?
  end

  def completed
    if self.completed?
      COMPLETE
    else
      IN_PROGRESS
    end
  end
  def completed?
    tasks_remaining == 0 and assignments_remaining == 0
  end
  def error
    if !completed? and Time.now > Week3.finish_date
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
    count+= 1 unless listen_to_attitude_message
    count+= 1 unless memorize_prayer_sheet_passage
    count+= 1 unless prayer_sheet
    count+= 1 unless recite_passage_from_dmpd_prayer_sheet
    count+= 1 unless practice_our_teams_current_financial_needs
    count+= 1 unless practice_tandems_financial_policy
    count+= 1 unless review_how_to_develop_your_ministry_partners
    count+= 1 unless share_call_testimony
    count+= 1 unless share_salvation_testimony
    count
  end
  def assignments_remaining!
    assignments_remaining > 0
  end
  def assignments_remaining
    count = 0
    count+= 1 unless vision_folder.exists?
    count
  end

end
