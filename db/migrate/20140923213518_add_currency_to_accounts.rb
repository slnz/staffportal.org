class AddCurrencyToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :currency, :string, default: 'nzd'
  end
end
