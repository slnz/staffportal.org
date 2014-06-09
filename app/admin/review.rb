ActiveAdmin.register Review do
  menu parent: 'Campus Reports'
  permit_params :open, :due
end
