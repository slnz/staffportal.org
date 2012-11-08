class Account < ActiveRecord::Base
  attr_accessible :code, :name
  has_many :user_accounts
  has_many :users, :through => :user_accounts
  has_many :records
  has_many :goals
  validates_uniqueness_of :code
  validates_presence_of :code

  def code=(setter)
    write_attribute :code, setter.gsub(/~/, '')
  end
end
