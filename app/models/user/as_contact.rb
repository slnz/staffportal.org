class User
  class AsContact < ActiveType::Record[User]
    validates :ministry, presence: true
    validates :primary_phone, presence: true
    validates :primary_phone, phony_plausible: true
    validates :home_phone, phony_plausible: true
    validates :office_phone, phony_plausible: true

    belongs_to :ministry
    has_many :children, class_name: 'User::Child', foreign_key: :user_id

    accepts_nested_attributes_for :children,
                                  reject_if: :all_blank,
                                  allow_destroy: true

    phony_normalize :primary_phone, default_country_code: 'NZ'
    phony_normalize :home_phone, default_country_code: 'NZ'
    phony_normalize :office_phone, default_country_code: 'NZ'

    before_save :update_search_field

    def build_children
      children.build
    end

    protected

    def update_search_field
      self.search =
        "%%#{first_name}%%#{last_name}%%#{address}%%" \
        "#{primary_phone}%%#{home_phone}%%#{office_phone}%%#{email}%%"
    end
  end
end
