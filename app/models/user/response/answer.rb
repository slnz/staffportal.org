class User
  class Response
    class Answer < ActiveRecord::Base
      belongs_to :response
      belongs_to :question, class_name: 'Review::Question'
    end
  end
end
