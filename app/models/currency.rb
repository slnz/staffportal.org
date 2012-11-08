class Currency < ActiveRecord::Base
  attr_accessible :code, :name
  validates_uniqueness_of :code
  has_many :currency_rates
  has_many :users
end
