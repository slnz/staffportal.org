class AddXpToUsers < ActiveRecord::Migration
  def change
    add_column :users, :XP, :integer, default: 0
  end
end
