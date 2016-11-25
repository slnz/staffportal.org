class User
  class AsAccountHolder < ActiveType::Record[User]
    has_many :permissions,
             class_name: '::User::Permission',
             foreign_key: 'user_id'
    has_many :accounts, through: :permissions, class_name: '::Account'
  end
end
