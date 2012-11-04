class AddByToUserAccount < ActiveRecord::Migration
  def change
    add_column :user_accounts, :by_id, :integer
  end
end
