class Roadblock < ActiveRecord::Base
  validates :title, presence: true
  validates :message, presence: true
end
