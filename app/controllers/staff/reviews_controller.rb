class Staff::ReviewsController < StaffController
  inherit_resources

  defaults resource_class: UserReview

  add_breadcrumb 'people and culture', :reviews_path
  def index
    if current_user.pac?

      @review = review
      @categories = []
      @graph = current_user.user_reviews
      .joins('INNER JOIN "review_questions" ON "review_questions"."id"' \
            ' = "user_review_answers"."review_question_id"')
      .joins(:user_review_answers)
      .joins(:review)
      .where('reviews.open > ?', 2.years.ago)
      .group('reviews.id')
      .select('array_agg(user_review_answers.value) as values',
              'array_agg(review_questions.text) as text',
              'reviews.open as date')
      .map do |r|
        r[:text].each do |text|
          @categories << text unless @categories.include?(text)
        end
        @values = {}
        r[:values].each_with_index do |value, index|
          @values[r[:text][index]] = value
        end
        { values: @values, date: r[:date].financial_quarter }
      end
      @series = []

      @graph.each do |question|
        @values_array = []
        @categories.each do |text|
          @values_array << question[:values][text].to_int || 0
        end
        @series << { name: question[:date], data: @values_array }
      end
    else
      render 'signup'
    end
  end

  def new
    @review = review
    if @review.nil?
      flash[:alert] = 'No pending reviews!'
      redirect_to reviews_path
      return
    end
    @review_questions = ReviewQuestion.all
  end

  def create
    @review = review

    if @review.nil?
      flash[:alert] = 'No pending reviews!'
      redirect_to reviews_path
      return
    end

    @ur = UserReview.create(review_id: @review.id,
                            user_id: current_user.id)
    params[:answer].each do |key, answer|
      UserReviewAnswer.create(review_question_id: key,
                              user_review_id: @ur.id,
                              value: answer.to_i)
    end

    flash[:achievement] = [] if flash[:achievement].nil?

    # Paperwork Hero Achievement
    flash[:achievement] << current_user.add_achievement('paperwork hero').id

    # Speedy Achievement
    if UserReview.where(review_id: @review.id).count <= 20
      flash[:achievement] << current_user.add_achievement('speedy').id
    end

    redirect_to reviews_path
  end

  def signup
    current_user.pac = true
    current_user.save!
    redirect_to action: :index
  end

  private

  def review
    @review =
      Review.where('open <= ? and due >= ?', Date.today, Date.today).first
    unless @review.nil?
      @review = nil unless current_user.user_reviews
                                        .find_by_review_id(@review.id)
                                        .nil?
    end

    @review
  end
end
