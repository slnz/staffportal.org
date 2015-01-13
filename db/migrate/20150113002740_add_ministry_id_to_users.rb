class AddMinistryIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ministry_id, :integer
  end
end
