class Staff::Dmpd::Week5Controller < InheritedResources::Base
  respond_to :html, :only => [:show, :edit, :update]
  before_filter :authenticate_user!
  def show
    redirect_to staff_dmpd_root_path, :notice => "Saved '5 Weeks to Bootcamp' Settings"
  end
end
