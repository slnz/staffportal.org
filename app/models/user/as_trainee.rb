class User::AsDmpd < ActiveType::Record[User]
  has_many :support_raising_developments
  has_many :contact_card_box
  has_many :appointment_set_records
  has_many :contacts
  has_many :user_assignments
end
