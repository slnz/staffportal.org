class AddWeeksToAppointmentSetRecords < ActiveRecord::Migration
  def change
  	rename_column :appointment_set_records, :week_id, :date_set_week_id
    add_column :appointment_set_records, :date_of_appointment_week_id, :integer
    add_column :appointment_set_records, :gift_date_week_id, :integer
    add_column :appointment_set_records, :gift_confirmed_date_week_id, :integer
    remove_column :appointment_set_records, :frequency_id
    add_column :appointment_set_records, :frequency, :decimal
  end
end
