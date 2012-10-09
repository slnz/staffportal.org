class ApplicationController < ActionController::Base
  protect_from_forgery
  def authenticate_admin_user!
    authenticate_user!
    unless current_user.role?("admin")
      redirect_to root_path, :notice => "This area is restricted to administrators only."
    end
  end

  def authenticate_coach_user!
    authenticate_user!
    unless current_user.role?("coach")
      redirect_to root_path, :notice => "This area is restricted to administrators only."
    end
  end

  def authenticate_hr_user!
    authenticate_user!
    unless current_user.role?("hr")
      redirect_to root_path, :notice => "This area is restricted to administrators only."
    end
  end

  def current_admin_user
    return nil if user_signed_in? && !current_user.role?("admin")
    current_user
  end

  def current_coach_user
    return nil if user_signed_in? && !current_user.role?("coach")
    current_user
  end

  def current_hr_user
    return nil if user_signed_in? && !current_user.role?("coach")
    current_user
  end

  def current_special_user
    return nil if user_signed_in? && !current_user.admin?
    current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_special_user)
  end
end
