class Event < ActiveRecord::Base
  has_many :registrations, class_name: 'User::Registration'
  has_many :users, through: :registrations, class_name: 'User::AsAttendee'

  belongs_to :logo, class_name: 'User::Document'
  belongs_to :programme, class_name: 'User::Document'
  belongs_to :venue, class_name: 'User::Document'
  belongs_to :speaker, class_name: 'User::Document'
  belongs_to :information, class_name: 'User::Document'

  validates :name, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :finish_date, presence: true
  validates :adult_cost, presence: true
  validates :logo, presence: true
  validates :teen_cost, presence: true, if: :teens_can_attend?
  validates :child_cost, presence: true, if: :children_can_attend?
  validate :start_must_be_before_end_time

  private

  def start_must_be_before_end_time
    errors.add(:start_date, 'must be before finish date') unless
      finish_date && start_date && finish_date > start_date
  end
end
