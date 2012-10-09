class Week6Controller < InheritedResources::Base
  before_filter :authenticate_user!
  def show
    redirect_to '/staff/bootcamp', :notice => "Saved '6 Weeks to Bootcamp' Settings"
  end
end
