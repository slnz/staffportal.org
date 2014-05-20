class AuthController < ApplicationController
  before_filter :authenticate_user!, except: [:home, :relay]
  def home
    unless current_user.nil?
      redirect_to '/staff'
    end
  end

  def relay
  end

  def key
    redirect_to '/staff'
  end
end
