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

  def to_label
    "#{self.code} - #{self.name}"
  end

  def update_balance
    balance = 0
    Record.after_save.clear
    records = self.records.order('date ASC, id ASC').includes(:type).all
    records.each do |record|
      if record.type.is_income
         balance += record.amount
      elsif record.type.is_expense
         balance -= record.amount
      end
      if balance != record.balance
        record.balance = balance
        record.save
      end
    end
  end

  def get_balance(current_user)
    acct = self.records.order('date DESC, id desc').first
    if acct.nil?
      0
    else
      @currency_rate = current_user.currency.currency_rates.where(:month => acct.month).first
      @vehicle_advance = self.records.joins(:type).where("types.code" => "1225").sum(:amount)
      @stock = self.records.joins(:type).where("types.code" => "1350").sum(:amount)
      if @currency_rate.blank?
        acct.balance - @stock - @vehicle_advance
      else
        (acct.balance - @stock - @vehicle_advance) * @currency_rate.rate
      end
    end
  end

  def last_updated
    acct = self.records.order('date DESC, id desc').first
    if acct.nil?
      Time.now.strftime('%d %b %Y')
    else
      acct.date.strftime('%d %b %Y')
    end
  end
end
