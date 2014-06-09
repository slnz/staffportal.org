class AddReviewsForNextTwentyYears < ActiveRecord::Migration
  def change
    @date = Date.today.next_financial_quarter
    (1..80).each do |index|
      Review.create(open: @date,
                    due: @date + 15.days)
      @date = @date.next_financial_quarter
    end
  end
end
