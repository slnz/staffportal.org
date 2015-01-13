class Account
  class Record < ActiveRecord::Base
    default_scope { order('date ASC, id ASC') }

    Account::Category.states.each do |key, _index|
      scope key.to_sym, (lambda do
        where category_id: Account::Category.try(key.to_sym).pluck(:id)
      end)
    end

    belongs_to :account
    belongs_to :category
    validates :amount, presence: true
    validates :date, presence: true
    validates :category, presence: true
    validates :account, presence: true
    paginates_per 50

    def date=(date)
      super
      self.month = self.date.beginning_of_month
    end
  end
end
