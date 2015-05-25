module Merit
  class BadgesSash < ActiveRecord::Base
    def self.last_granted(options = {})
      options[:since_date] ||= 1.month.ago
      options[:limit]      ||= 10
      where("created_at > '#{options[:since_date]}'")
        .limit(options[:limit])
        .map(&:user_badge)
    end

    def user_badge
      {
        user: User.find_by_sash_id(sash_id),
        badge: Badge.find(badge_id)
      }
    end
  end
end
