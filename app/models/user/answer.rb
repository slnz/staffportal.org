class User::Answer < ActiveRecord::Base
  # attr_accessible :review_question_id, :user_review_id, :value
  belongs_to :user_review
  belongs_to :review_question
end
