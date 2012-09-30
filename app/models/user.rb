class User < ActiveRecord::Base
  attr_accessible :admin, :username
  has_one :week6
  has_many :contacts
end
