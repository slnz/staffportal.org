class AddRegistrationInformationToEvents < ActiveRecord::Migration
  def change
    add_column :events, :registration_information, :text
  end
end
