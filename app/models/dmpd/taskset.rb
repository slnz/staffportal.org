module Dmpd
  class Taskset < ActiveRecord::Base
    self.table_name = 'dmpd_tasksets'
    has_many :assignments, dependent: :destroy
    has_many :user_assignments, class_name: '::User::Assignment'
    accepts_nested_attributes_for :assignments

    def due_week
      Date.commercial Time.now.year, super, 7
    end
  end
end
