class User
  class Assignment < ActiveRecord::Base
    belongs_to :user
    belongs_to :assignment, class_name: 'Dmpd::Assignment'
    belongs_to :taskset, class_name: 'Dmpd::Taskset'
    belongs_to :document
  end
end
