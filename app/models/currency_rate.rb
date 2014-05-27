class CurrencyRate < ActiveRecord::Base
  # attr_accessible :currency_id, :month, :rate
  validates_presence_of :month, :rate
  validates_uniqueness_of :month, scope: :currency_id
  belongs_to :currency
end
