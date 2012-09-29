class User < ActiveRecord::Base
  attr_accessible :admin, :username
end
