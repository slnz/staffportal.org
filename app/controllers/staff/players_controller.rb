module Staff
  class PlayersController < StaffController
    add_breadcrumb 'leaderboard', :players_path

    def index
      load_players
      decorate_players
    end

    protected

    def load_players
      @players ||= player_scope.all
    end

    def decorate_players
      @players = @players.try(:decorate)
    end

    def player_scope
      User::AsPlayer.where('roles_mask & ? = ?',
                 User.mask_for(:player),
                 User.mask_for(:player))
    end

    def user_type
      :player
    end
  end
end
