class Record < ActiveRecord::Base
  belongs_to :account
  belongs_to :type
  attr_accessible :amount, :date, :reason, :subtext, :who, :account_id, :type_id, :balance
  validates_presence_of :amount, :date, :type, :account
  paginates_per 50

  before_save :update_balance

  after_save :update_external_balances

  def update_balance
      if id.nil?
        query = account.records.where("date <= ?", self.date).order('date DESC, id DESC').first
      else
        query = account.records.where("id < ? and date = ? or id <> ? and date < ?", self.id, self.date, self.id, self.date).order('date DESC, id DESC').first
      end
      if type.is_income
        unless query.nil?
           self.balance = query.balance + self.amount
        else
           self.balance = self.amount # First movement
        end
      else
        unless query.nil?
           self.balance = query.balance - self.amount
        else
           self.balance = -self.amount # First movement
        end
      end
  end

  def update_external_balances
      record = account.records.where("id > ? and date = ? or id <> ? and date > ?", self.id, self.date, self.id, self.date).order('date DESC, id DESC').last
      unless record.nil?
        record.update_balance
        record.save
      end
  end
end
