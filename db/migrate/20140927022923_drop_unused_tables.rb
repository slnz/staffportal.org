class DropUnusedTables < ActiveRecord::Migration
  def change
    drop_table :week1s
    drop_table :week2s
    drop_table :week3s
    drop_table :week4s
    drop_table :week5s
    drop_table :week6s
    drop_table :currency_rates
    drop_table :currencies
    drop_table :xp_levels
    drop_table :achievements
  end
end
