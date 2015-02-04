class User
  class Permission < ActiveRecord::Base
    self.table_name = 'user_accounts'
    belongs_to :user
    belongs_to :account
    belongs_to :by, class_name: 'User', foreign_key: 'by_id'
  end
end
