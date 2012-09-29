class Week6Controller < InheritedResources::Base
  def show
    redirect_to 'staff/bootcamp', :notice => "Saved Week 6 Settings"
  end
end
