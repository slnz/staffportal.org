class User < ActiveRecord::Base
  devise :cas_authenticatable, :trackable
  # attr_accessible :currency_id, :username, :first_name,
  #                 :last_name, :email, :admin, :id, :bootcamp_coach_id, :xp
  validates_presence_of :username, :email
  belongs_to :bootcamp_coach, class_name: 'User'
  has_many :trainees, class_name: 'User', foreign_key: 'bootcamp_coach_id'
  has_one :week6
  has_one :week5
  has_one :week4
  has_one :week3
  has_one :week2
  has_one :week1
  belongs_to :currency
  has_many :contacts
  has_many :user_accounts
  has_many :accounts, through: :user_accounts
  has_many :user_reviews
  has_many :user_review_answers
  has_many :reviews, through: :user_reviews
  has_many :support_raising_developments
  has_many :contact_card_box
  has_many :appointment_set_record
  has_many :user_achievements
  has_many :achievements, through: :user_achievements

  before_save do
    username.downcase! if username
  end

  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end

  def cas_extra_attributes=(extra_attributes)
    extra_attributes.each do |name, value|
      case name.to_sym
      when :firstName
        self.first_name = value
      when :lastName
        self.last_name = value
      when :email
        self.email = value
      end
    end
  end

  def name
    name = "#{first_name} #{last_name}"
    name = username if first_name.blank? && last_name.blank?
    name
  end

  def role?(role)
    admin == role
  end

  def admin?
    admin != ''
  end

  def is_admin?
    admin != 'admin'
  end

  def currency_code
    if currency.nil?
      self.currency = Currency.where(code: 'NZD').
                               first_or_create(name: 'New Zealand Dollar')
      save
    end
    currency.code
  end

  def support_raising_development
    support_raising_developments
  end

  def late_support_raising_developments
    hide_weeks = []
    support_raising_developments.each do |srd|
      hide_weeks << srd.week_id
    end
    Week.where('id not in (?) and date_finished < ?',
               hide_weeks,
               Time.now.to_date).count
  end

  def late_contact_card_box
    hide_weeks = []
    contact_card_box.each do |ccb|
      hide_weeks << ccb.week_id
    end
    Week.where('id not in (?) and date_finished < ?',
               hide_weeks,
               Time.now.to_date).count
  end

  def mpd_goal
    my_account = accounts.where('name LIKE (?)',
                                "%#{last_name}%#{first_name}%").
                          first
    unless my_account.nil?
      @goal = my_account.goals.find_by_type_id(164)
      return @goal.amount.to_i unless @goal.nil?
    end
    mpd_goal
  end

  def xp_level
    XpLevel.where('xp_min <= ? and xp_max > ?',
                  self.XP,
                  self.XP).first
  end

  def add_achievement(name)
    achievement = Achievement.where(name: name).first
    unless achievement.nil?
      UserAchievement.create(user_id: id,
                             achievement_id: achievement.id)
      self.XP += achievement.xp_value
      save!
    end
    achievement
  end
end
