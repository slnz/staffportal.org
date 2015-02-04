class ChangeHoursOnSupportRaisingDevelopments < ActiveRecord::Migration
  def change
    change_column :support_raising_developments, :hours_calling, :decimal, default: 0
  end
end
