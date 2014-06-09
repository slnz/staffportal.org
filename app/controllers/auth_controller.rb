class AuthController < ApplicationController
  before_filter :authenticate_user!, except: [:home]
  def home
    render layout: 'signed_out'
  end

  def key
    if Roadblock.where('created_at > ?', current_user.last_sign_in_at).exists?
      redirect_to since_youve_been_gone_path
    else
      redirect_to root_path
    end
  end
end
