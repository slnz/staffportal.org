class RemoveDateSetFromAppointmentSetRecords < ActiveRecord::Migration
  def change
    remove_column :appointment_set_records, :date_set, :date
  end
end
