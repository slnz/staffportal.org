class User < ActiveRecord::Base
  attr_accessible :admin, :username
  has_one :user
end
