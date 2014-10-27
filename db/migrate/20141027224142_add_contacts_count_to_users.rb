class AddContactsCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :contacts_count, :integer, default: 0
    User.all.each do |user|
      User.update_counters user.id, contacts_count: user.contacts.count
    end
  end
end
