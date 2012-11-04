class Type < ActiveRecord::Base
  attr_accessible :is_income, :name
  validates_uniqueness_of :name
  has_many :records
end
