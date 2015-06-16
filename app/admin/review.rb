ActiveAdmin.register Review do
  menu parent: 'People & Culture'
  permit_params :open, :due

  member_action :download, method: :get do
    review = Review.find(params[:id])
    questions_array = Review::Question.order(:id).all
    question_ids =  questions_array.map(&:id)
    questions =  questions_array.map(&:text)
    csv = CSV.generate(encoding: 'Windows-1251') do |csv_data|
      csv_data << %w(date name) + questions
      review.responses.each do |response|
        csv_data <<
        [response.created_at, response.user.try(:decorate).try(:name)] +
        response.answers.order(:question_id).where(question_id: question_ids).pluck(:value)
      end
    end
    send_data csv.encode('Windows-1251'),
              type: 'text/csv; charset=windows-1251; header=present',
              disposition: 'attachment; filename=report.csv'
  end

  action_item :download, only: :show do
    link_to 'Download Submissions', action: 'download'
  end
end
