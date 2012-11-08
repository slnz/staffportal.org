class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currency_rates do |t|
      t.date :month
      t.decimal :rate
      t.timestamps
    end
  end
end
