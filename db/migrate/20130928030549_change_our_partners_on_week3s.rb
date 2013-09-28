class ChangeOurPartnersOnWeek3s < ActiveRecord::Migration
  def change
  	remove_column :week3s, :practice_our_teams_current_financial_needs
	add_column(:week3s, :practice_our_teams_current_financial_needs, :boolean)
  end
end
