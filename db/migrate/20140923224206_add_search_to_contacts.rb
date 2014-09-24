class AddSearchToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :search, :text
  end
end
