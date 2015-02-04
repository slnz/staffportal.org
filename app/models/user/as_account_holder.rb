class User
  class AsAccountHolder < ActiveType::Record[User]
    has_many :permissions,
             class_name: '::User::Permission',
             foreign_key: 'user_id'
    has_many :accounts, through: :permissions, class_name: '::Account'

    def mpd_goal
      my_account =
        accounts.where('name LIKE (?)', "%#{last_name}%#{first_name}%").first
      unless my_account.nil?
        @goal = my_account.goals.find_by_category_id(164)
        return @goal.amount.to_i unless @goal.nil?
      end
      mpd_goal
    end
  end
end