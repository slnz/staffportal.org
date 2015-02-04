class Ministry < ActiveRecord::Base
  validates :name, presence: true
end
