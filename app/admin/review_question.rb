ActiveAdmin.register ReviewQuestion do
  menu parent: 'Campus Reports'
  permit_params :text

  index do
    selectable_column
    column :id
    column :text
    actions
  end
end
