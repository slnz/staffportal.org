class User
  class AsTrainee < ActiveType::Record[User]
    scope :trainees, lambda {
      where('roles_mask & ? = ?',
            User::AsTrainee.mask_for(:trainee),
            User::AsTrainee.mask_for(:trainee))
    }
    has_many :user_assignments, class_name: 'User::Assignment', foreign_key: 'user_id'
    has_many :logs, class_name: 'Dmpd::Log', foreign_key: 'user_id'
    has_many :contacts, class_name: 'Dmpd::Contact', foreign_key: 'user_id'
  end
end
