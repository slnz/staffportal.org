class User
  class AsContact < ActiveType::Record[User]
    validates :ministry, presence: true
    validates :primary_phone, presence: true
    validates :primary_phone, phony_plausible: true
    validates :home_phone, phony_plausible: true
    validates :office_phone, phony_plausible: true
    has_many :kids, foreign_key: :user_id

    accepts_nested_attributes_for :kids,
                                  reject_if: :all_blank,
                                  allow_destroy: true

    phony_normalize :primary_phone, default_country_code: ENV['country_code']
    phony_normalize :home_phone, default_country_code: ENV['country_code']
    phony_normalize :office_phone, default_country_code: ENV['country_code']

    before_save :update_search_field

    def password=(password)
      super(password) unless password.blank?
    end

    def build_kid
      kids.build
    end

    protected

    def update_search_field
      self.search =
        "%%#{first_name}%%#{last_name}%%#{address}%%" \
        "#{primary_phone}%%#{home_phone}%%#{office_phone}%%#{email}%%"
    end
  end
end
