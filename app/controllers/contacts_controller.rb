class ContactsController < InheritedResources::Base
  before_filter CASClient::Frameworks::Rails::Filter
  def index
    redirect_to '/staff/bootcamp', :notice => "Contact Removed"
  end
  def show
    redirect_to '/staff/bootcamp', :notice => "Contact Created"
  end
  def delete
    redirect_to '/staff/bootcamp', :notice => "Contact Removed"
  end
end
