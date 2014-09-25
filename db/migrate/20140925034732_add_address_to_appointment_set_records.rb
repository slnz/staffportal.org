class AddAddressToAppointmentSetRecords < ActiveRecord::Migration
  def change
    add_column :appointment_set_records, :address, :string
  end
end
