class Taskset < ActiveRecord::Base
  has_many :assignments, dependent: :destroy
  has_many :user_assignments
  accepts_nested_attributes_for :assignments

  def due_week
    Date.commercial Time.now.year, super, 7
  end
end
