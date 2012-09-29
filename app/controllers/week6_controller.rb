class Week6Controller < InheritedResources::Base
  before_filter CASClient::Frameworks::Rails::Filter
  def show
    redirect_to '/staff/bootcamp', :notice => "Saved '6 Weeks to Bootcamp' Settings"
  end
end
