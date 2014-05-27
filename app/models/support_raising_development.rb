class SupportRaisingDevelopment < ActiveRecord::Base
  validates_uniqueness_of :week_id, scope: :user_id
  validates_presence_of :appointments_asked_for, :contacts_asked_for,
                        :number_of_calls_made, :week_id, :hours_calling
  # attr_accessible :appointments_asked_for, :contacts_asked_for,
  #                 :number_of_calls_made, :week_id, :hours_calling
  belongs_to :user
  belongs_to :week

  def created_at_print
    created_at.strftime('%a, %d %b %y')
  end
end
