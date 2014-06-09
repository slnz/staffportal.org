class UserReview < ActiveRecord::Base
  # attr_accessible :review_id, :user_id
  belongs_to :user
  belongs_to :review
  has_many :user_review_answers
  has_many :review_questions, through: :user_review_answers
end
