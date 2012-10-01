class ApplicationController < ActionController::Base
  protect_from_forgery
  def authenticate_active_admin_user!
    if !current_user.is_admin?
      redirect_to root_path, :notice => "Unauthorized Access!"
    end
  end
  def current_active_admin_user
    User.find(session[:user_id])
  end
end
