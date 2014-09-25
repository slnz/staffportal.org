class AddNotesToAppointmentSetRecords < ActiveRecord::Migration
  def change
    add_column :appointment_set_records, :notes, :text
  end
end
