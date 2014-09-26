class User < ActiveRecord::Base
  devise :cas_authenticatable, :trackable
  # attr_accessible :currency_id, :username, :first_name,
  #                 :last_name, :email, :admin, :id, :bootcamp_coach_id, :xp
  validates_presence_of :username, :email
  belongs_to :bootcamp_coach, class_name: 'User'
  has_many :trainees, class_name: 'User', foreign_key: 'bootcamp_coach_id'
  has_many :documents
  has_many :contacts
  has_many :user_accounts
  has_many :accounts, through: :user_accounts
  has_many :user_reviews
  has_many :user_review_answers
  has_many :reviews, through: :user_reviews
  has_many :support_raising_developments
  has_many :contact_card_box
  has_many :appointment_set_records
  has_many :user_achievements
  has_many :achievements, through: :user_achievements
  has_many :user_assignments

  has_many :gma_memberships
  has_many :gma_organizations, through: :gma_memberships
  has_many :gma_staff_reports
  has_many :gma_measurements, through: :gma_staff_reports

  attr_encrypted :password

  validates :encrypted_password,
            symmetric_encryption: true,
            unless: -> { encrypted_password.blank? }
  validate :key_password

  validates :primary_phone, presence: true
  validates :primary_phone, phony_plausible: true
  validates :home_phone, phony_plausible: true
  validates :office_phone, phony_plausible: true

  phony_normalize :primary_phone, default_country_code: 'NZ'
  phony_normalize :home_phone, default_country_code: 'NZ'
  phony_normalize :office_phone, default_country_code: 'NZ'

  before_save do
    username.downcase! if username
  end

  after_save :gma_update!

  def gma_update!
    unless encrypted_password.nil? || gma_update? || !encrypted_password_changed?
      self.update_column(
        :gma_update, Job::GmaGetUserMeasurements.create(user_id: self.id)
      )
    end
  end

  def gma_update?
    return false if status.nil?
    return false if status.completed? || status.failed?
    return true
  end

  def status
    Resque::Plugins::Status::Hash.get(self.read_attribute(:gma_update))
  end

  def key_password
    return if password.blank?
    response = HTTParty.post('https://thekey.me/cas/v1/tickets',
                  body: { username: email, password: password })
    if response.code != 201
      errors.add(:password, 'Incorrect Password')
    end
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
