class ApplicationController < ActionController::Base
  protect_from_forgery

  add_breadcrumb 'home', :authenticated_root_path

  def authenticate_admin_user!
    fail CanCan::AccessDenied unless current_user.has_role? :admin
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
end
