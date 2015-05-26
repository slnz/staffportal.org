class AuthController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  def index
    if request.fullpath == root_path
      render layout: 'signed_out'
    else
      session[:stored_url] ||= request.url
      redirect_to root_path
    end
  end

  def key
    if Roadblock.where('created_at > ?', current_user.last_sign_in_at).exists?
      redirect_to since_youve_been_gone_path
    else
      redirect_to session[:stored_url] || root_path
    end
  end
end
