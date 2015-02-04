class Account < ActiveRecord::Base
  has_many :user_accounts
  has_many :users, through: :user_accounts
  has_many :records
  has_many :goals
  validates :code, uniqueness: true, presence: true
  validates :currency, presence: true
  validates :name, presence: true

  def code=(code)
    super code.gsub(/~/, '')
  end

  def update_balance
    balance = 0
    Record.after_save.clear
    return if records.nil?
    records.includes(:category).each do |record|
      if record.category.income?
        balance += record.amount
      elsif record.category.expense? ||
            record.category_id == 161 ||
            record.category_id == 163
        balance -= record.amount
      end
      next unless balance != record.balance
      record.balance = balance
      record.save
    end
  end
end
