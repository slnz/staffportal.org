class AddEmergencyContactDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :emergency_contact_name, :string
    add_column :users, :emergency_contact_phone, :string
    add_column :users, :emergency_contact_relationship, :string
  end
end
