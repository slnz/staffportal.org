class UserAccount < ActiveRecord::Base
  belongs_to :user
  belongs_to :account
  belongs_to :by, class_name: 'User', foreign_key: 'by_id'
  attr_accessible :user_id, :account_id, :by_id
end
