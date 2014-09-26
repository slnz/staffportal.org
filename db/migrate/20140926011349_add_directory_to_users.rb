class AddDirectoryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :primary_phone, :string
    add_column :users, :home_phone, :string
    add_column :users, :office_phone, :string
    add_column :users, :address, :string
  end
end
