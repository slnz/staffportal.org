class RemoveAppointmentsSetupFromSupportRaisingDevelopments < ActiveRecord::Migration
  def change
  	remove_column :support_raising_developments, :appointments_setup
  end
end
