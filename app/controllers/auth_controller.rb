class AuthController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter, :except => [ :home, :relay ]
  def home

  end
  def relay

  end
  def key
    @user = User.where(:username => session[:cas_user]).first_or_create
    session[:user_id] = @user.id
    redirect_to '/staff'
  end
  def logout
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
