class Type < ActiveRecord::Base
  attr_accessible :is_income, :name
  has_many :records
end
