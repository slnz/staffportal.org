class Contact < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :phone, :user_id
  validates_presence_of :first_name, :last_name, :phone
  belongs_to :user

  def name
    "#{self.first_name} #{self.last_name}"
  end
end
