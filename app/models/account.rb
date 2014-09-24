class Account < ActiveRecord::Base
  # attr_accessible :code, :name
  has_many :user_accounts
  has_many :users, through: :user_accounts
  has_many :records
  has_many :goals
  validates_uniqueness_of :code
  validates_presence_of :code
  validates_presence_of :currency
  validates_presence_of :name

  def code=(setter)
    write_attribute :code, setter.gsub(/~/, '')
  end

  def to_label
    "#{code} - #{name}"
  end

  def update_balance
    balance = 0
    Record.after_save.clear
    return if records.nil?
    records.order('date ASC, id ASC').includes(:type).each do |record|
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
    @record = records.order('date DESC, id desc').first
    @record.blank? ? 0 : @record.balance
  end

  def last_updated
    acct = records.order('date DESC, id desc').first
    if acct.nil?
      Time.now.strftime('%b %Y')
    else
      acct.date.strftime('%b %Y')
    end
  end
end
