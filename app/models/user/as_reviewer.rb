class User
  class AsReviewer < ActiveType::Record[User]
    has_many :user_reviews, class_name: 'User::Review', foreign_key: :user_id
    has_many :answers, through: :user_reviews
    has_many :reviews, through: :user_reviews
  end
end
