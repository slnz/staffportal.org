ActiveAdmin.register User do
  decorate_with UserDecorator
  filter :email
  filter :created_at
  filter :updated_at
  index do
    selectable_column
    column :name
    column :email
    actions
  end

  form do |f|
    f.inputs title: 'User' do
      f.input :first_name
      f.input :last_name
      f.input :username
    end
    f.actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
    end
  end

  permit_params :first_name, :last_name, :email
end
