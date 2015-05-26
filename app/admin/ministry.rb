ActiveAdmin.register Ministry do
  decorate_with MinistryDecorator
  config.sort_order = 'id_asc'

  filter :name

  index do
    selectable_column
    column :id
    column :name
    actions
  end

  permit_params :name
end
