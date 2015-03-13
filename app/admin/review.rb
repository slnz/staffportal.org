ActiveAdmin.register Review do
  menu parent: 'People & Culture'
  permit_params :open, :due

  member_action :download, method: :get do
    review = Review.find(params[:id])
    question_ids = Review::Question.pluck(:id)
    questions = Review::Question.pluck(:text)
    csv = CSV.generate(encoding: 'Windows-1251') do |csv_data|
      csv_data << ['name'] + questions
      review.responses.each do |response|
        csv_data <<
        [response.user.try(:decorate).try(:name)] +
        response.answers.where(question_id: question_ids).pluck(:value)
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
