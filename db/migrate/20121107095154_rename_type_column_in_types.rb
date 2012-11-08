class RenameTypeColumnInTypes < ActiveRecord::Migration
  def change
    rename_column :types, :type, :definition
  end
end
