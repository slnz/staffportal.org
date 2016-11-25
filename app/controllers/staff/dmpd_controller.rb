module Staff
  class DmpdController < StaffController
    before_action :authenticate_user!
    add_breadcrumb 'dmpd', :dmpd_path

    def index
    end

    def signup
      add_breadcrumb 'signup', :url_for
      return unless params[:activate]
      current_user.roles << user_type
      current_user.save
      redirect_to 'https://dmpd.staffportal.org'
    end

    protected

    def user_type
      :trainee
    end
  end
end
