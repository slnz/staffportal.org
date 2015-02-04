module Staff
  class ReviewsController < StaffController
    add_breadcrumb 'people and culture', :reviews_path
    def index
      load_user_reviews
      load_review
      load_graph
    end

    def new
      load_review
      return redirect_to reviews_path if @review.nil?
      load_questions
      build_user_review
    end

    def create
      load_review
      build_user_review
      return flash[:success] = 'Successfully submitted your review' if save_user_review
      load_questions
      flash.now[:error] = 'There was a problem submitting your review'
      render action: :new
    end

    protected

    def load_user_reviews
      @user_reviews ||= user_review_scope
    end

    def load_graph
      @graph ||= User::ReviewsDecorator.graph(current_user)
    end

    def load_review
      @review ||=
        Review.where('open <= ? and due >= ?', Date.today, Date.today).first
      return if user_review_scope.find_by(review: @review).nil?
      @review = nil
    end

    def load_questions
      @questions ||= Review::Question.all
    end

    def build_user_review
      @user_review ||= user_review_scope.build(review: @review)
      @user_review.attributes = review_params
    end

    def save_user_review
      redirect_to reviews_path if @user_review.save
    end

    def user_review_scope
      current_user.user_reviews
    end

    def user_type
      :reviewer
    end

    def review_params
      return {} unless params[:user_review]
      Params.permit(params)
    end

    class Params
      def self.permit(params)
        params.require(:user_review)
          .permit(answers_attributes: [:review_question_id, :value])
      end
    end
  end
end
