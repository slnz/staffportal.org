class ContactsController < InheritedResources::Base
  before_filter CASClient::Frameworks::Rails::Filter
  def index
    redirect_to '/staff/bootcamp', :notice => "Contact Removed"
  end
  def create
    if params[:contact][:first_name].empty? or params[:contact][:last_name].empty? or params[:contact][:phone].empty?
      redirect_to '/staff/bootcamp', :notice => "Missing Contact Field Data".html_safe
    else
      params[:contact][:first_name] = params[:contact][:first_name].capitalize
      params[:contact][:last_name] = params[:contact][:last_name].capitalize
      params[:contact][:phone] = params[:contact][:phone].gsub(/[^0-9]/, "")
      @exists = Contact.where(:first_name => params[:contact][:first_name],:last_name => params[:contact][:last_name], :phone => params[:contact][:phone]).first
      if @exists.nil?
        @exists = Contact.where(:phone => params[:contact][:phone]).first
      end
      if @exists.nil?
        super
      else
        redirect_to '/staff/bootcamp', :notice => "Contact already claimed by <a href=\"mailto:#{@exists.user.username}\">#{@exists.user.username}</a>".html_safe
      end
    end
  end
  def show
    redirect_to '/staff/bootcamp', :notice => "Contact Created"
  end
  def delete
    redirect_to '/staff/bootcamp', :notice => "Contact Removed"
  end
end
