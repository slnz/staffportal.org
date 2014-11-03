class RefactorMovedTables < ActiveRecord::Migration
  def change
    rename_table :goals, :account_goals
    rename_table :records, :account_records
    rename_table :types, :account_types
    rename_table :appointment_set_records, :dmpd_appointments
    rename_table :assignments, :dmpd_assignments
    rename_table :contacts, :dmpd_contacts
    rename_table :contact_card_boxes, :dmpd_contact_card_boxes
    rename_table :support_raising_developments, :dmpd_weekly_calls
    rename_table :tasksets, :dmpd_tasksets
    rename_table :weeks, :dmpd_weeks
    rename_table :documents, :user_documents
  end
end
