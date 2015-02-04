class User
  class Kid < ActiveRecord::Base
    belongs_to :as_contact, class_name: 'User::AsContact', primary_key: :user_id

    enum swimming_capability: [
      :unable,
      :fair,
      :good,
      :strong
    ]

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :media_waiver, presence: true
    validates :swimming_capability, presence: true
    validates :date_of_birth, presence: true
  end
end
