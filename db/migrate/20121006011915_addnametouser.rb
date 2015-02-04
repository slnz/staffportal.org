class Addnametouser < ActiveRecord::Migration
  def change
    change_table :users do |t  |
    t.string :first_nam  e
    t.string :last_nam  e
  end
end
end
