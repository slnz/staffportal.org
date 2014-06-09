class AddGmaUpdateToGmaStaffReports < ActiveRecord::Migration
  def change
    add_column :gma_staff_reports, :gma_update, :string
  end
end
