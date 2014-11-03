class Staff::Dmpd::IndexController < StaffController
  before_action :authenticate_user!

  add_breadcrumb 'dmpd', :dmpd_root_path
  def index
    render 'signup' unless current_user.dmpd?
  end

  def signup
    current_user.dmpd = true
    current_user.save!
    redirect_to action: :index
  end
end
