class AddConferenceRegistrationInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :dietary_requirements, :text
    add_column :users, :medical_requirements, :text
  end
end
