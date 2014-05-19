class CreateReviewQuestions < ActiveRecord::Migration
  def change
    create_table :review_questions do |t|
      t.string :text

      t.timestamps
    end
  end
end
