ActiveAdmin.register User do
  actions :index, :show, :edit

  index do
    selectable_column
    column ("Name") { |user| user.name }
    column :email
    column :bootcamp_coach
    column ("Role") { |user|
      if user.admin.blank?
        status_tag("None")
      else
        status_tag(user.admin, "orange")
      end }
    default_actions
  end

  batch_action :make_hr do |selection|
    User.find(selection).each do |user|
      user.admin = "hr"
      user.save
    end
    redirect_to collection_path, :notice => "Added HR role to selected!"
  end

  batch_action :make_coach do |selection|
    User.find(selection).each do |user|
      user.admin = "coach"
      user.save
    end
    redirect_to collection_path, :notice => "Added Coach role to selected!"
  end

  batch_action :deauthorize do |selection|
    User.find(selection).each do |user|
      user.admin = ""
      user.save
    end
    redirect_to collection_path, :notice => "Removed all roles from selected!"
  end

  form do |f|
    f.inputs :title => "Bootcamp" do
      f.input :bootcamp_coach
    end
    f.buttons
  end
end
