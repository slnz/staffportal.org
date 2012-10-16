class Week5Controller < InheritedResources::Base
  before_filter :authenticate_user!
  def show
    redirect_to '/staff/bootcamp', :notice => "Saved '5 Weeks to Bootcamp' Settings"
  end
end
