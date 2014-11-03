class Staff::Dmpd::Stats::BaseController < StaffController
  add_breadcrumb 'dmpd', :dmpd_root_path
  add_breadcrumb 'statistics', :dmpd_stats_root_path
  def index
    begin
      @mpd_goal =
        (current_user.accounts
                      .where('accounts.name LIKE ?',
                             "%#{current_user.last_name}%")
                      .joins(goals: :type)
                      .where("types.definition = 'IN'")
                      .group('accounts.id')
                      .sum(:amount)
                      .first[1])
                      .to_d / 12
    rescue
      @mpd_goal = 0
    end
    @weeks =
      Week.where('date_finished < ?',
                 Time.now.to_date + 1.week)
           .order('date_finished desc')
           .page params[:page]
  end

  def contact_ratio
  end
end
