class User < ActiveRecord::Base
  devise :cas_authenticatable
  attr_accessible :currency_id, :username, :first_name, :last_name, :email, :admin, :id, :bootcamp_coach_id
  validates_presence_of :username, :email
  belongs_to :bootcamp_coach, :class_name => "User"
  has_many :trainees, :class_name => "User", :foreign_key => "bootcamp_coach_id"
  has_one :week6
  belongs_to :currency
  has_many :contacts
  has_many :user_accounts
  has_many :accounts, :through => :user_accounts

  before_save do
    self.username.downcase! if self.username
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
    name = "#{self.first_name} #{self.last_name}"
    name = self.username if self.first_name.blank? and self.last_name.blank?
    name
  end

  def username=(name)
    super
    self.email = name
  end
  def role?(role)
    self.admin == role
  end

  def admin?
    self.admin != ''
  end

  def is_admin?
    self.admin != 'admin'
  end

  def currency_code
    if self.currency.nil?
      self.currency = Currency.where(:code => 'NZD').first_or_create(:name => 'New Zealand Dollar')
      self.save
    end
    self.currency.code
  end
end
