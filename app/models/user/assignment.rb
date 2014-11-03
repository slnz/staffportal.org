class User::Assignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :assignment
  belongs_to :taskset
  belongs_to :document
end
