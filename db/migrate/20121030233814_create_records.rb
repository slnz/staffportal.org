class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.integer :account_id
      t.decimal :amount
      t.integer :type_id
      t.date :date
      t.text :reason
      t.string :who
      t.text :subtext

      t.timestamps
    end
  end
end
