ActiveAdmin.register UserAccount do
  menu :parent => "Finance", :label => "Permissions"
  index do
    selectable_column
    column :user
    column :account
    column :created_at
    column :by
    default_actions
  end

  form do |f|
    f.inputs "Permissions" do
      f.input :user
      f.input :account
      f.input :by_id, :as => :hidden, :input_html => { :value => current_user.id }
    end
    f.buttons
  end
end
