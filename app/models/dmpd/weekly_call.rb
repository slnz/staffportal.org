class Dmpd::WeeklyCall < ActiveRecord::Base
  validates :week_id, uniqueness: { scope: :user_id }
  validates :appointments_asked_for, presence: true
  validates :contacts_asked_for, presence: true
  validates :number_of_calls_made, presence: true
  validates :week_id, presence: true
  validates :hours_calling, presence: true
  belongs_to :user
  belongs_to :week

  def created_at_print
    created_at.strftime('%a, %d %b %y')
  end
end
