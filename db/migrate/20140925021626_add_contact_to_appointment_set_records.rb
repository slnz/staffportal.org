class AddContactToAppointmentSetRecords < ActiveRecord::Migration
  def change
    remove_column :appointment_set_records, :first_name, :string
    remove_column :appointment_set_records, :last_name, :string
    add_column :appointment_set_records, :contact_id, :integer
  end
end
