class User < ActiveRecord::Base
  devise :cas_authenticatable
  attr_accessible :username, :first_name, :last_name, :email, :admin, :id, :bootcamp_coach_id
  belongs_to :bootcamp_coach, :class_name => "User"
  has_many :trainees, :class_name => "User", :foreign_key => "bootcamp_coach_id"
  has_one :week6
  has_many :contacts

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
    "#{self.first_name} #{self.last_name}"
  end

  def role?(role)
    self.admin == role
  end

  def admin?
    self.admin != ''
  end
end
