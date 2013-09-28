class Staff::Dmpd::Week1Controller < InheritedResources::Base
  respond_to :html, :only => [:show, :edit, :update]
  before_filter :authenticate_user!
  def show
    redirect_to staff_dmpd_root_path, :notice => "Saved Taskset 6"
  end
end
