class UserReviewAnswer < ActiveRecord::Base
  attr_accessible :review_question_id, :user_review_id, :value
end
