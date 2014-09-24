class Contact < ActiveRecord::Base
  paginates_per 25
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :primary_phone, presence: true
  validates :priority_code, presence: true
  has_one :referer, class_name: 'Contact', foreign_key: 'referer_id'
  belongs_to :user
  before_save :update_search_field

  validates :primary_phone, phony_plausible: true
  validates :home_phone, phony_plausible: true
  validates :office_phone, phony_plausible: true

  phony_normalize :primary_phone, default_country_code: 'NZ'
  phony_normalize :home_phone, default_country_code: 'NZ'
  phony_normalize :office_phone, default_country_code: 'NZ'

  enum priority_code: [:A, :B, :C]

  def name
    "#{first_name} #{last_name}"
  end

  def initials
    first_name[0, 1] + last_name[0, 1]
  end

  protected

  def update_search_field
    self.search =
      "%%#{first_name}%%#{last_name}%%#{address}%%#{occupation}%%#{church}%%" +
      "#{primary_phone}%%#{home_phone}%%#{office_phone}%%#{email}%%#{children}"
  end
end
