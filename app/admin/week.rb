ActiveAdmin.register Week do
  menu parent: 'DMPD'

  action_item only: :index do
    link_to 'Add 12 Weeks to System', action: 'add_week'
  end

  collection_action :add_week do
    w = Week.order(:date_finished).last
    if w.nil?
      w = Week.new(date_start: Time.to_date.beginning_of_week)
      w.save
    end
    (1..12).each do
      w = Week.new(date_start: w.date_finished + 1.day)
      w.save
    end

    flash[:notice] = 'Created!'
    redirect_to action: :index
  end

end
