class Assignment < ActiveRecord::Base
  enum kind: [:text, :boolean, :upload]
  has_many :user_assignments, dependent: :destroy
  belongs_to :taskset
  accepts_nested_attributes_for :user_assignments
end
