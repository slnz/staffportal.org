class CreateUserReviews < ActiveRecord::Migration
  def change
    create_table :user_reviews do |t|
      t.integer :review_id
      t.integer :user_id

      t.timestamps
    end

    add_index :user_reviews, :review_id
    add_index :user_reviews, :user_id
  end
end
