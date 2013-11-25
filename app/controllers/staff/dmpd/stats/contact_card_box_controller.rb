class Staff::Dmpd::Stats::ContactCardBoxController < InheritedResources::Base
  before_filter :authenticate_user!

  def index
		@late = current_user.late_contact_card_box
		@contact_card_box = current_user.contact_card_box
  end

	def new
		@contact_card_box = ContactCardBox.new
		hide_weeks = [-1]
		current_user.contact_card_box.each do |ccb|
			hide_weeks << ccb.week_id
		end
		@available_weeks = Week.where('id not in (?) and date_finished < ?', hide_weeks, Time.now.to_date + 1.week)
		@contact_card_box.week = @available_weeks.first
	end

	def create
		create!(:notice => "Dude! Nice job creating your weekly contact card box statistics.") { staff_dmpd_stats_contact_card_box_index_path }
	end

	def update
		update!(:notice => "Dude! Nice job updating your weekly contact card box statistics.") { staff_dmpd_stats_contact_card_box_index_path }
	end

  protected
    def begin_of_association_chain
      current_user
    end
end