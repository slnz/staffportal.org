class AuthController < ApplicationController
  before_filter :authenticate_user!, except: [:home]
  def home
    unless current_user.nil?
      redirect_to '/staff'
    end
  end

  def key
    redirect_to '/staff'
  end
end
