ActiveAdmin.register Dmpd::Assignment do
  menu parent: 'DMPD'

  permit_params :taskset_id, :name, :kind

  form do |f|
    f.inputs 'Details' do
      f.input :taskset
      f.input :name
      f.input :kind, as: :select, collection: Assignment.kinds.keys
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :taskset
    column :name
    column :kind
    actions
  end
end
