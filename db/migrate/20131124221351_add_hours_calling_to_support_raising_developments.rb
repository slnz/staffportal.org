class AddHoursCallingToSupportRaisingDevelopments < ActiveRecord::Migration
  def change
    add_column :support_raising_developments, :hours_calling, :integer
  end
end
