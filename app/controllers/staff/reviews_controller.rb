module Staff
  class ReviewsController < StaffController
    add_breadcrumb 'people and culture', :reviews_path
    def index
      load_responses
      load_review
      load_graph
    end

    def new
      load_review
      return redirect_to reviews_path if @review.nil?
      load_questions
      build_response
    end

    def create
      load_review
      build_response
      if save_response
        current_user.add_badge(0)
        current_user.add_points(20, category: 'reviews')
        if User::Response.where(review: @response.review).count <= 20
          current_user.add_badge(1)
          current_user.add_points(50, category: 'reviews')
        end
        return flash[:success] = 'Successfully submitted your review'
      end
      load_questions
      flash.now[:error] = 'There was a problem submitting your review'
      render action: :new
    end

    protected

    def load_responses
      @responses ||= response_scope
    end

    def load_graph
      @graph ||= User::ReviewsDecorator.graph(current_user)
    end

    def load_review
      @review ||=
        Review.where('open <= ? and due >= ?', Date.today, Date.today).first
      return if response_scope.find_by(review: @review).nil?
      @review = nil
    end

    def load_questions
      @questions ||= Review::Question.all
    end

    def build_response
      @response ||= response_scope.build(review: @review)
      @response.attributes = response_params
    end

    def save_response
      redirect_to reviews_path if @response.save
    end

    def response_scope
      current_user.responses
    end

    def user_type
      :reviewer
    end

    def response_params
      return {} unless params[:user_response]
      Params.permit(params)
    end

    class Params
      def self.permit(params)
        params.require(:user_response)
          .permit(answers_attributes: [:question_id, :value])
      end
    end
  end
end
