class User
  class Review < ActiveRecord::Base
    self.table_name = 'user_reviews'
    belongs_to :user
    belongs_to :review
    has_many :answers, class_name: 'User::Review::Answer', foreign_key: :user_review_id
    accepts_nested_attributes_for :answers
    validates :user, presence: true
    validates :review, presence: true
  end
end
