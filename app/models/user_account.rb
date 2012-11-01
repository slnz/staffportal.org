class UserAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  attr_accessible :user_id, :account_id
end
