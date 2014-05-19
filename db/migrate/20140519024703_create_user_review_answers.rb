class CreateUserReviewAnswers < ActiveRecord::Migration
  def change
    create_table :user_review_answers do |t|
      t.integer :user_review_id
      t.integer :review_question_id
      t.integer :value

      t.timestamps
    end

    add_index :user_review_answers, :user_review_id
    add_index :user_review_answers, :review_question_id
  end
end
