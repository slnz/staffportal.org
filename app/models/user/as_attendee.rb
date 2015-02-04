class User
  class AsAttendee < ActiveType::Record[User]
    has_many :registrations,
             class_name: 'User::Registration',
             foreign_key: :user_id
    has_many :events, through: :registrations
  end
end
