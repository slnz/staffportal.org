class ChangeCodeToStringOnAccounts < ActiveRecord::Migration
  def change
    change_column :accounts, :code, :string
  end
end
