class AddStatusToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :status, :integer, default: 0
  end
end
