module Dmpd
  class Contact < ActiveRecord::Base
    self.table_name = 'dmpd_contacts'
    paginates_per 500
    has_one :referer,
            class_name: 'Contact',
            primary_key: 'referer_id',
            foreign_key: 'id'
    belongs_to :user, counter_cache: true
    before_save :update_search_field

    validates :user, presence: true
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :primary_phone, presence: true, uniqueness: true
    validates :priority_code, presence: true
    validates :status, presence: true
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

    scope :confirmed, -> { where(confirmed: true) }

    def frequency=(frequency)
      super frequency.to_d
    end

    def self.frequencies
      { 'Special' => (0.0).to_d,
        'Weekly' => (0.23076923076923).to_d,
        'Fortnightly' => (0.46153846153846).to_d,
        'Monthly' => (1.0).to_d,
        'Bi-Monthly' => (2.0).to_d,
        'Quarterly' => (3.0).to_d,
        'Semi-Annual' => (6.0).to_d,
        'Annual' => (12.0).to_d,
        'Biennial' => (24.0).to_d }
    end

    def status=(status)
      super(status)
      self.category = status.to_s.split('_')[0].to_sym unless status.nil?
    end

    protected

    def update_search_field
      self.search =
        "%%#{first_name}%%#{last_name}%%#{address}%%#{occupation}%%#{church}%%"\
        "#{primary_phone}%%#{home_phone}%%#{office_phone}%%#{email}%%"\
        "#{children}%%#{status}"
    end
  end
end
