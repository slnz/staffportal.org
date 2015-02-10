class Account
  class Category < ActiveRecord::Base
    validates :code, presence: true, uniqueness: true
    validates :name, presence: true
    has_many :records
    has_many :goals
    enum state: [:income,
                 :expense,
                 :current_asset,
                 :current_liability
                ]
    enum effect: [:no_effect,
                  :add,
                  :subtract
                 ]
    scope :salary, -> { where(salary: true) }
  end
end
