class Review < ActiveRecord::Base
  validates :open, presence: true
  validates :due, presence: true
  validates :open,
            presence: true
  validates :due, presence: true
  validate :start_must_be_before_end_time

  private

  def start_must_be_before_end_time
    errors.add(:open, 'must be before due') unless due && open && due > open
  end
end
