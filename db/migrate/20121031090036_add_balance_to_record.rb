class AddBalanceToRecord < ActiveRecord::Migration
  def change
    add_column :records, :balance, :decimal, default: 0
  end
end
