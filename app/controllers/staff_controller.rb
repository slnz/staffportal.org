class StaffController < ApplicationController
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to action: 'signup'
  end

  def signup
    add_breadcrumb 'signup', :url_for
    return unless params[:activate]
    current_user.roles << user_type
    current_user.save
    redirect_to action: :index
  end

  protected

  def user_type
    :user
  end

  def current_user
    return super.try(:decorate) if user_type == :user || params[:action] == 'signup'
    super.try(:decorate).try(:as, user_type)
  end
end
