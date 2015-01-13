module Dmpd
  class Assignment < ActiveRecord::Base
    self.table_name = 'dmpd_assignments'
    enum kind: [:text, :boolean, :upload]
    has_many :user_assignments, dependent: :destroy, class_name: 'User::Assignment'
    belongs_to :taskset
    accepts_nested_attributes_for :user_assignments
    validates :name, presence: true
    validates :taskset, presence: true
    validates :kind, presence: true
  end
end
