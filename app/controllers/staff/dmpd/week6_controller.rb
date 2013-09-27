class Staff::Dmpd::Week6Controller < InheritedResources::Base
  respond_to :html, :only => [:show, :edit, :update]
  before_filter :authenticate_user!
  def show
    redirect_to staff_dmpd_root_path, :notice => "Saved Taskset 1"
  end
end
