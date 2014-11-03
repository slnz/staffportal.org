class User::AsReviewer < ActiveType::Record[User]
  has_many :user_reviews
  has_many :user_review_answers
  has_many :reviews, through: :user_reviews
end
