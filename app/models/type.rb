class Type < ActiveRecord::Base
  attr_accessible :code, :definition, :name
  validates_uniqueness_of :code
  validates_presence_of :code, :definition
  has_many :records
  has_many :goals

  def is_income
    self.definition == "IN" or self.code == "1301" or self.code == "P1301"
  end

  def is_expense
    self.definition == "EX"
  end
end
