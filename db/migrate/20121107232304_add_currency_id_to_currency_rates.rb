class AddCurrencyIdToCurrencyRates < ActiveRecord::Migration
  def change
    add_column :currency_rates, :currency_id, :integer
  end
end
