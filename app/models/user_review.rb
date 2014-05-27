class UserReview < ActiveRecord::Base
  # attr_accessible :review_id, :user_id
  belongs_to :user
  belongs_to :review
end
