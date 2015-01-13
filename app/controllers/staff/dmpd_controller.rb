module Staff
  class DmpdController < StaffController
    before_action :authenticate_user!
    add_breadcrumb 'dmpd', :dmpd_path

    def index
    end

    protected

    def user_type
      :trainee
    end
  end
end
