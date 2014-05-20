module Staff
  class ReviewsController < InheritedResources::Base
    defaults resource_class: UserReview
    def index
      @review = get_review
      @xp = current_user.xp_level
    end

    def new
      @review = get_review
      if @review.nil?
        flash[:alert] = 'No pending reviews!'
        redirect_to staff_reviews_path
        return
      end
      @review_questions = ReviewQuestion.all
    end

    def create
      @review = get_review

      if @review.nil?
        flash[:alert] = 'No pending reviews!'
        redirect_to staff_reviews_path
        return
      end

      @ur = UserReview.create(review_id: @review.id,
                              user_id: current_user.id)
      params[:answer].each do |key, answer|
        UserReviewAnswer.create(review_question_id: key,
                                user_review_id: @ur.id,
                                value: answer.to_i)
      end

      flash[:achievement] = Array.new if flash[:achievement].nil?

      # Paperwork Hero Achievement
      flash[:achievement] << current_user.add_achievement('paperwork hero')

      # Speedy Achievement
      if UserReview.where(review_id: @review.id).count <= 20
        flash[:achievement] << current_user.add_achievement('speedy')
      end

      redirect_to staff_reviews_path
    end

    private

    def get_review
      @review = Review.
                       where('open <= ? and due >= ?',
                             Time.now,
                             Time.now).
                       first
      unless @review.nil?
        @review = nil unless current_user.user_reviews.
                                          find_by_review_id(@review.id).
                                          nil?
      end

      @review
    end
  end
end
