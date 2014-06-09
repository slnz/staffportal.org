class AddGmaUpdateToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gma_update, :string
  end
end
