class AddMonthToRecord < ActiveRecord::Migration
  def up
    add_column :records, :month, :date
    Record.all.each do |record|
      record.month = record.date.beginning_of_month
      record.save
    end
  end

  def down
    remove_column :records, :month, :date
  end
end
