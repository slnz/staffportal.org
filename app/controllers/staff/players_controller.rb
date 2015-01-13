module Staff
  class PlayersController < StaffController
    add_breadcrumb 'leaderboard', :players_path

    def index
      @users = User.where('"XP" > 0').limit(10).order('"XP" desc').decorate
    end

    protected

    def user_type
      :player
    end
  end
end
