ActiveAdmin.register Review::Question do
  menu parent: 'People & Culture'
  permit_params :text

  index do
    selectable_column
    column :id
    column :text
    actions
  end
end
