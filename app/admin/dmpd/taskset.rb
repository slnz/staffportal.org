ActiveAdmin.register Dmpd::Taskset, as: 'Taskset' do
  menu parent: 'DMPD'
  permit_params :name, :due_week
end
