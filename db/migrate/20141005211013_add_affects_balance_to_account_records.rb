class AddAffectsBalanceToAccountRecords < ActiveRecord::Migration
  def change
    add_column :account_records, :affects_balance, :boolean, default: true
  end
end
