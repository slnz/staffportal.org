class AddUserIdToAppointmentSetRecord < ActiveRecord::Migration
  def change
    add_column :appointment_set_records, :user_id, :integer
  end
end
