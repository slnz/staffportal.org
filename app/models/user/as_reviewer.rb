class User
  class AsReviewer < ActiveType::Record[User]
    scope :reviewers, lambda {
      where('roles_mask & ? = ?',
            User::AsReviewer.mask_for(:reviewer),
            User::AsReviewer.mask_for(:reviewer))
    }
    has_many :responses, foreign_key: :user_id, dependent: :destroy
    has_many :answers, through: :responses, class_name: 'User::Response::Answer'
    has_many :reviews, through: :responses
  end
end
