class Account::Goal < ActiveRecord::Base
  belongs_to :account
  belongs_to :category
  validates :account, presence: true
  validates :category, presence: true
  validates :amount, presence: true
  Account::Category.states.each do |key, _index|
    scope key.to_sym, (lambda do
      where category_id: Account::Category.try(key.to_sym).pluck(:id)
    end)
  end
  scope :salary, -> { where category_id: Account::Category.salary.pluck(:id) }
end
