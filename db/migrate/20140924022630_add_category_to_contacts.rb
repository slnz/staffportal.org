class AddCategoryToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :category, :integer, default: 0
  end
end
