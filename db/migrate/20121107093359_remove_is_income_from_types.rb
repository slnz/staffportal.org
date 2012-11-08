class RemoveIsIncomeFromTypes < ActiveRecord::Migration
  def change
    remove_column :types, :is_income
    add_column :types, :type, :string
    add_column :types, :code, :string
  end
end
