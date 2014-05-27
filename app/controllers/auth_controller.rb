class AuthController < ApplicationController
  before_filter :authenticate_user!, except: [:home]
  def home
    if current_user.nil?
      add_breadcrumb 'sign in', :root_path
      @fullwidth = true
    else
      redirect_to '/staff'
    end
  end

  def key
    redirect_to '/staff'
  end
end
