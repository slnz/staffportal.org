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

  def update_balance(balance = 0)
    return unless records
    records.includes(:category).each do |record|
      balance += record.amount if record.category.add?
      balance -= record.amount if record.category.subtract?
      record.update(balance: balance) if record.balance != balance
    end
  end
end
