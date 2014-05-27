class Account < ActiveRecord::Base
  # attr_accessible :code, :name
  has_many :user_accounts
  has_many :users, through: :user_accounts
  has_many :records
  has_many :goals
  validates_uniqueness_of :code
  validates_presence_of :code

  def code=(setter)
    write_attribute :code, setter.gsub(/~/, '')
  end

  def to_label
    "#{code} - #{name}"
  end

  def update_balance
    balance = 0
    Record.after_save.clear
    records = records.order('date ASC, id ASC').includes(:type).all
    records.each do |record|
      if record.type.income?
        balance += record.amount
      elsif record.type.expense? ||
            record.type_id == 161 ||
            record.type_id == 163
        balance -= record.amount
      end
      if balance != record.balance
        record.balance = balance
        record.save
      end
    end
  end

  def get_balance(current_user)
    @currency_rate = current_user.currency.currency_rates.order(:month).last
    @currency_rate = @currency_rate.blank? ? 1 : @currency_rate.rate
    @record = records.order('date DESC, id desc').first
    @record.blank? ? 0 : @record.balance * @currency_rate
  end

  def last_updated
    acct = records.order('date DESC, id desc').first
    if acct.nil?
      Time.now.strftime('%d %b %Y')
    else
      acct.date.strftime('%d %b %Y')
    end
  end
end
