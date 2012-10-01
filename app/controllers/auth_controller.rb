class AuthController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter, :except => [ :home, :relay ]
  def home
    if !session[:cas_user].nil?
      redirect_to '/staff'
    end
  end
  def relay

  end
  def key
    @user = User.where(:username => session[:cas_user]).first_or_create
    session[:user_id] = @user.id
    redirect_to '/staff'
  end
  def logout
    session[:user_id] = nil
    CASClient::Frameworks::Rails::Filter.logout(self)
  end
end
