class User
  class Review
    class Answer < ActiveRecord::Base
      belongs_to :user_review, class_name: 'User::Review'
      belongs_to :review_question, class_name: 'Review::Question'
    end
  end
end
