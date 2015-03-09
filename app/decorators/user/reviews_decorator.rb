require 'user'
class User
  class ReviewsDecorator < PaginationDecorator
    def self.graph(current_user)
      returnable = { categories: [], series: [] }
      reviews_scope(current_user).each do |r|
        returnable[:categories] = r[:text] if returnable[:categories].empty?
        returnable[:series] <<
          { name: r[:date].financial_quarter, data: r[:values] }
      end
      returnable
    end

    def self.reviews_scope(current_user)
      current_user.answers
        .joins(:question)
        .group('date_trunc(\'day\', user_response_answers.created_at)')
        .select('first(user_response_answers.created_at) as date,'\
        'array_agg(review_questions.text) as text,'\
        'array_agg(user_response_answers.value) as values')
    end
  end
end
