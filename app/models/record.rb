class Record < ActiveRecord::Base
  belongs_to :account
  belongs_to :type
  attr_accessible :amount, :date, :reason, :subtext, :who, :account_id, :type_id, :balance, :month
  validates_presence_of :amount, :date, :type, :account
  paginates_per 50

  def date=(date)
    super
    self.month = self.date.beginning_of_month
  end
end
