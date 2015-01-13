class AddSearchToUsers < ActiveRecord::Migration
  def change
    add_column :users, :search, :string
  end
end
