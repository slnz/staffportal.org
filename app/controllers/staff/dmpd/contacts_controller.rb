class Staff::Dmpd::ContactsController < InheritedResources::Base
  before_filter :authenticate_user!

  respond_to :html, :only => [:index, :show, :update, :create, :delete]
  def index
    redirect_to staff_dmpd_root
  end
  def create
    if params[:contact][:first_name].empty? or params[:contact][:last_name].empty? or params[:contact][:phone].empty?
      flash[:notice] = "Missing Contact Field Data".html_safe
      redirect_to staff_dmpd_contacts_path
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
        flash[:notice] = "Contact already claimed by <a href=\"mailto:#{@exists.user.username}\">#{@exists.user.username}</a>".html_safe
        redirect_to staff_dmpd_contacts_path
      end
    end
  end
  def show
    flash[:notice] = "Contact Created"
    redirect_to staff_dmpd_contacts_path
  end
  def delete
    flash[:notice] = "Contact Removed"
    redirect_to staff_dmpd_contacts_path
  end
end