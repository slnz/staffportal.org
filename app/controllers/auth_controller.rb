class AuthController < ApplicationController
  before_filter CASClient::Frameworks::Rails::Filter, :except => [ :home, :relay ]
  def home

  end
  def relay

  end
  def key
    redirect_to '/staff'
  end
end
