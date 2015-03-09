class ChangeUserReviewsToUserResponses < ActiveRecord::Migration
  def change
    rename_table :user_reviews, :user_responses
    rename_table :user_review_answers, :user_response_answers
    rename_column :user_response_answers, :user_review_id, :response_id
    rename_column :user_response_answers, :review_question_id, :question_id
  end
end
