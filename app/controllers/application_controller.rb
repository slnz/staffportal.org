class ApplicationController < ActionController::Base
  protect_from_forgery

  add_breadcrumb 'home', :authenticated_root_path

  def authenticate_admin_user!
    true
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
