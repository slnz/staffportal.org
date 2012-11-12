ActiveAdmin.register User do

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
    @Coaches = User.where("admin = 'hr' OR admin = 'coach'").all
    f.inputs :title => "User" do
      f.input :first_name
      f.input :last_name
      f.input :username
    end
    f.inputs :title => "Bootcamp" do
      f.input :bootcamp_coach, :collection => @Coaches, :input_html => { :class => 'chosen'}
    end
    f.inputs :title => "Finances" do
      f.input :currency, :input_html => { :class => 'chosen'}
    end
    f.buttons
  end

  show :title => :name do |user|
    attributes_table do
      row :name
      row :username
      row :currency
      row("admin") { |user| status_tag(user.admin, "orange") }
    end

    panel "Contacts" do
      table_for(user.contacts) do
        column :name
        column :phone
      end
    end
  end
end
