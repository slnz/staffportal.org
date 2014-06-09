class ApplicationController < ActionController::Base
  protect_from_forgery

  add_breadcrumb 'home', :authenticated_root_path

  def authenticate_admin_user!
    authenticate_user!
    redirect_to root_path,
                notice: admin_message unless current_user.role?('admin')
  end

  def authenticate_coach_user!
    authenticate_user!
    redirect_to root_path,
                notice: admin_message unless current_user.role?('coach')
  end

  def authenticate_hr_user!
    authenticate_user!
    redirect_to root_path,
                notice: admin_message unless current_user.role?('hr')
  end

  def current_admin_user
    return nil if user_signed_in? && !current_user.role?('admin')
    current_user
  end

  def current_coach_user
    return nil if user_signed_in? && !current_user.role?('coach')
    current_user
  end

  def current_hr_user
    return nil if user_signed_in? && !current_user.role?('coach')
    current_user
  end

  def current_special_user
    return nil if user_signed_in? && !current_user.admin?
    current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_special_user)
  end

  private

  def admin_message
    'This area is restricted to administrators only.'
  end
end
