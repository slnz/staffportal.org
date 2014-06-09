module Staff
  class IndexController < ApplicationController
    before_filter :authenticate_user!
    def index

    end

    def leaderboard
      add_breadcrumb 'leaderboard', :leaderboard_path
      @users = User.where('"XP" > 0').limit(10).order('"XP" desc')
    end

    def roadblock
      if Roadblock.where('created_at > ?', current_user.last_sign_in_at).exists?
        @rb = Roadblock.where('created_at > ?', current_user.last_sign_in_at).
                  order('created_at').
                  last
        render layout: 'signed_out'
      else
        redirect_to root_path
      end
    end
  end
end
