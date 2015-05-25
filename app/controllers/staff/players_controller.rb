module Staff
  class PlayersController < StaffController
    add_breadcrumb 'leaderboard', :players_path

    def index
      load_scores
    end

    protected

    def load_players
      @players ||= player_scope.order(:points).all
    end

    def load_scores
      @scores ||= Merit::Score.top_scored
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
