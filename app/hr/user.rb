ActiveAdmin.register User, :namespace => :hr do
  actions :index, :show

  index do
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

  show :title => :name do |user|
    attributes_table do
      row :name
      row :email
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
