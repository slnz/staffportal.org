class User < ActiveRecord::Base
  scope :admins, -> { where('roles_mask & ? > 0', User.mask_for(:admin)) }
  scope :account_holders, -> { where('roles_mask & ? > 0', User.mask_for(:account_holder)) }
  scope :contacts, -> { where('roles_mask & ? > 0', User.mask_for(:contact)) }
  scope :reviewers, -> { where('roles_mask & ? > 0', User.mask_for(:reviewer)) }
  scope :statisticians, -> { where('roles_mask & ? > 0', User.mask_for(:statistician)) }
  scope :trainees, -> { where('roles_mask & ? > 0', User.mask_for(:trainee)) }
  scope :players, -> { where('roles_mask & ? > 0', User.mask_for(:player)) }
  scope :attendees, -> { where('roles_mask & ? > 0', User.mask_for(:attendee)) }
  has_merit
  include RoleModel
  devise :trackable, :cas_authenticatable
  paginates_per 50
  validates :email, presence: true
  has_many :documents
  belongs_to :ministry
  roles :account_holder,
        :contact,
        :reviewer,
        :statistician,
        :trainee,
        :player,
        :attendee,
        :admin,
        :trainer,
        :hr
  attr_encrypted :password

  validates :encrypted_password,
            symmetric_encryption: true,
            unless: -> { encrypted_password.blank? }

  def cas_extra_attributes=(extra_attributes)
    extra_attributes.each do |name, value|
      case name.to_sym
      when :firstName
        self.first_name ||= value
      when :lastName
        self.last_name ||= value
      when :email
        self.email ||= value
      end
    end
  end

  def as(role)
    return becomes "User::As#{role.to_s.camelize}".constantize if self.is? role
    fail CanCan::AccessDenied
  end
end
