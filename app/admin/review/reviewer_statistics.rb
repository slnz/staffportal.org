ActiveAdmin.register User::AsReviewer, as: 'Reviewer Statistics' do
  actions :all, except: [:new, :edit, :create, :update, :destroy, :show]
  decorate_with User::AsReviewerDecorator
  menu parent: 'People & Culture'

  controller do
    def scoped_collection
      User::AsReviewer.reviewers.includes(:responses).includes(:reviews)
    end
  end

  filter :username
  filter :first_name
  filter :last_name

  index do
    column :name
    column('Last Review') do |user|
      user.responses.last.try(:review).try(:open)
    end
  end

  # show do |user|
  #   panel 'Reviewer Statistics' do
  #     table_for user.responses do
  #       column('Review Open Date') do |response|
  #         response.review.open
  #       end
  #       Review::Question.all.each do |question|
  #         column(question.text) do |response|
  #           response.answers.find_by(question: question).value
  #         end
  #       end
  #     end
  #   end
  #   columns do
  #     column do
  #       panel 'Monthly Pledged' do
  #         @metric = user.responses.includes(:answers).includes(:review).pluck(:open, :value)
  #         render partial: 'metrics/column_chart',
  #                locals: { metric: @metric, max: 10 }
  #       end
  #     end
  #   end
  # end
end
