class User < ActiveRecord::Base
  has_merit

  include RoleModel
  paginates_per 25
  devise :trackable, :cas_authenticatable
  validates :email, presence: true
  has_many :documents
  roles :account_holder, :contact, :reviewer, :statistician, :trainee, :player
  attr_encrypted :password
  belongs_to :ministry

  validates :encrypted_password,
            symmetric_encryption: true,
            unless: -> { encrypted_password.blank? }
  validate :key_password

  def key_password
    return if password.blank?
    response = HTTParty.post('https://thekey.me/cas/v1/tickets',
                             body: { username: email,
                                     password: password })
    return if response.code == 201
    errors.add(:password, 'Incorrect Password')
  rescue OpenSSL::Cipher::CipherError
    self.password = nil
    save
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

  def as(role)
    return becomes "User::As#{role.to_s.camelize}".constantize if self.is? role
    fail CanCan::AccessDenied
  end
end
