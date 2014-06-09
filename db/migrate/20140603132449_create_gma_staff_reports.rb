class CreateGmaStaffReports < ActiveRecord::Migration
  def change
    create_table :gma_staff_reports do |t|
      t.integer :user_id
      t.integer :gma_organization_id
      t.integer :gma_id
      t.date :end_date
      t.date :start_date
      t.integer :version
      t.boolean :submitted

      t.timestamps
    end
  end
end
