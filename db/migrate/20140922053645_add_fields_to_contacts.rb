class AddFieldsToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :priority_code, :integer
    add_column :contacts, :new_church, :boolean
    add_column :contacts, :email, :string
    add_column :contacts, :address, :string
    add_column :contacts, :primary_phone, :string
    add_column :contacts, :home_phone, :string
    add_column :contacts, :office_phone, :string
    add_column :contacts, :referer_id, :integer
    add_column :contacts, :how_knows, :string
    add_column :contacts, :occupation, :string
    add_column :contacts, :church, :string
    add_column :contacts, :children, :string
    add_column :contacts, :anniversary, :date
    remove_column :contacts, :phone, :string
  end
end
