class Account < ActiveRecord::Base
  attr_accessible :code, :name
  has_many :user_accounts
  has_many :users, :through => :user_accounts
  has_many :records
  validates_uniqueness_of :code
end
