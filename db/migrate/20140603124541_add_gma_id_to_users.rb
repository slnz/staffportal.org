class AddGmaIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :gma_id, :integer
  end
end
