class AddMonthlyToAppointmentSetRecords < ActiveRecord::Migration
  def change
    add_column :appointment_set_records, :monthly, :decimal
  end
end
