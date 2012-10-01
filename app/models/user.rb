class User < ActiveRecord::Base
  attr_accessible :admin, :username
  has_one :week6
  has_many :contacts
  def is_admin?
    if @admin == "admin" or @admin == "coach"
      true
    else
      false
    end
  end
end
