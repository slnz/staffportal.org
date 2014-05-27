class Type < ActiveRecord::Base
  # attr_accessible :code, :definition, :name
  validates_uniqueness_of :code
  validates_presence_of :code, :definition
  has_many :records
  has_many :goals

  def income?
    definition == 'IN' || code == '1301' || code == 'P1301'
  end

  def expense?
    definition == 'EX'
  end
end
