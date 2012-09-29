class Addconfirmationtoweek6 < ActiveRecord::Migration
  def change
    add_column :week6s, :confirmed_coach, :boolean
    add_column :week6s, :confirmed_hr, :boolean
  end
end
