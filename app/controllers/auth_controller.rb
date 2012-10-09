class AuthController < ApplicationController
  before_filter :authenticate_user!, :except => [ :home, :relay ]
  def home
    if !current_user.nil?
      redirect_to '/staff'
    end
  end
  def relay

  end
  def key
    redirect_to '/staff'
  end
  def logout
    session[:user_id] = nil
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
