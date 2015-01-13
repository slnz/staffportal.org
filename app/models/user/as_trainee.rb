class User
  class AsTrainee < ActiveType::Record[User]
    has_many :contacts, class_name: 'Dmpd::Contact', foreign_key: 'user_id'
    has_many :user_assignments, class_name: 'User::Assignment', foreign_key: 'user_id'
  end
end
