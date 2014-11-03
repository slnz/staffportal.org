class Dmpd::Contact < ActiveRecord::Base
  paginates_per 25
  has_one :referer, class_name: 'Contact', foreign_key: 'referer_id'
  has_many :appointment_set_records, dependent: :destroy
  belongs_to :user
  before_save :update_search_field

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :primary_phone, presence: true, uniqueness: true
  validates :priority_code, presence: true
  validates :primary_phone, phony_plausible: true
  validates :home_phone, phony_plausible: true
  validates :office_phone, phony_plausible: true

  phony_normalize :primary_phone, default_country_code: 'NZ'
  phony_normalize :home_phone, default_country_code: 'NZ'
  phony_normalize :office_phone, default_country_code: 'NZ'

  enum priority_code: [:A, :B, :C]

  enum status: [:base_new,
                :base_not_back_until,
                :base_office_phone_only,
                :base_needs_research,
                :callback_for_appointment,
                :callback_for_decision,
                :callback_for_contacts,
                :appointment_set,
                :appointment_none,
                :appointment_no_support,
                :appointment_new_ministry_partner,
                :maintain_call_in_a_year,
                :maintain_would_have_met,
                :maintain_on_list]

  enum category: [:base, :callback, :appointment, :maintain]

  def status=(status)
    super(status)
    return unless valid?
    self.callback! if status.to_s.include? 'callback'
    self.appointment! if status.to_s.include? 'appointment'
    self.maintain! if status.to_s.include? 'maintain'
    self.base! if status.to_s.include? 'base'
  end

  def name
    "#{first_name} #{last_name}".titleize
  end

  def initials
    first_name[0, 1] + last_name[0, 1]
  end

  protected

  def update_search_field
    self.search =
      "%%#{first_name}%%#{last_name}%%#{address}%%#{occupation}%%#{church}%%" \
      "#{primary_phone}%%#{home_phone}%%#{office_phone}%%#{email}%%" \
      "#{children}%%#{status}"
  end
end
