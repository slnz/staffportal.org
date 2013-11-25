class Staff::Dmpd::Stats::BaseController < ApplicationController
  before_filter :authenticate_user!
	def index
		begin
			@mpd_goal = (current_user.accounts.where("accounts.name LIKE ?", "%#{current_user.last_name}%").joins(goals: :type).where("types.definition = 'IN'").group('accounts.id').sum(:amount).first[1]).to_d / 12
		rescue
			@mpd_goal = 0
		end

		@weeks = Week.where('date_finished < ?', Time.now.to_date + 1.week)
	end

	def contact_ratio

	end
end