ActiveAdmin.register Currency do
  menu parent: 'Finance', label: 'Currency'

  index do
    selectable_column
    column :code
    column :name
    actions
  end

  config.filters = false

end
