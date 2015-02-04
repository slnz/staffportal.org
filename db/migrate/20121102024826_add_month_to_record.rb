class AddMonthToRecord < ActiveRecord::Migration
  def up
    add_column :records, :month, :date
  end

  def down
    remove_column :records, :month, :date
  end
end
