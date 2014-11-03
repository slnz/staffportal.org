class Dmpd::Assignment < ActiveRecord::Base
  enum kind: [:text, :boolean, :upload]
  has_many :user_assignments, dependent: :destroy
  belongs_to :taskset
  accepts_nested_attributes_for :user_assignments
  validates :name, presence: true
  validates :taskset, presence: true
  validates :kind, presence: true
end
