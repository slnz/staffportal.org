class User
  class Response < ActiveRecord::Base
    belongs_to :user
    belongs_to :review
    has_many :answers, dependent: :destroy
    accepts_nested_attributes_for :answers
    validates :user, presence: true
    validates :review, presence: true
  end
end
