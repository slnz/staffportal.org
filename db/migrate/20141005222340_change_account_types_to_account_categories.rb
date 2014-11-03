class ChangeAccountTypesToAccountCategories < ActiveRecord::Migration
  def change
    rename_table :account_types, :account_categories
    rename_column :account_goals, :type_id, :category_id
    rename_column :account_records, :type_id, :category_id
  end
end
