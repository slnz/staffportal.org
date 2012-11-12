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
      f.input :user, :input_html => { :class => 'chosen'}
      f.input :account, :input_html => { :class => 'chosen'}
      f.input :by_id, :as => :hidden, :input_html => { :value => current_user.id }
    end
    f.buttons
  end

  show do
    attributes_table do
      row :user
      row :account
      row :created_at
      row :by
    end
  end
end
