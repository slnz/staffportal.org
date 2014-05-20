module Staff
  class IndexController < ApplicationController
    before_filter :authenticate_user!
    def index
      @feed = Feedjira::Feed.fetch_and_parse('http://www.tandem.org.nz/' +
                                             'tools/blocks/problog_list/rss' +
                                             '?cID=187')
    end

    def leaderboard
      @users = User.where('"XP" > 0').limit(10).order('"XP" desc')
    end
  end
end
