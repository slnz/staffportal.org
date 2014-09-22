ActiveAdmin.register Review do
  menu parent: 'People & Culture'
  permit_params :open, :due
end
