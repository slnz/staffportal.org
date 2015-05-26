class User
  class Registration < ActiveRecord::Base
    belongs_to :user, class_name: 'User::AsAttendee'
    belongs_to :event

    validates :user, presence: true
    validates :event, presence: true
  end
end
