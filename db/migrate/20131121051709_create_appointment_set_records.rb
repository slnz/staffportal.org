class CreateAppointmentSetRecords < ActiveRecord::Migration
  def change
    create_table :appointment_set_records do |t|
      t.string :first_name
      t.string :last_name
      t.date :date_set
      t.date :date_of_appointment
      t.boolean :support
      t.decimal :amount
      t.integer :frequency_id
      t.date :gift_date
      t.date :gift_confirmed_date
      t.boolean :asked_for_contacts
      t.integer :number_of_contacts_received
      t.boolean :thank_you_posted
      t.integer :week_id

      t.timestamps
    end
  end
end
