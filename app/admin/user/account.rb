ActiveAdmin.register User::Permission, as: 'Permission' do
  menu parent: 'Accounts'
  permit_params :user_id, :account_id, :by_id
  index do
    selectable_column
    column :user
    column :account
    column :created_at
    column :by
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :user, input_html: { class: 'chosen' }
      f.input :account,
              input_html: { class: 'chosen' },
              include_blank: true,
              label_method: :to_label
      f.input :by_id, as: :hidden, input_html: { value: current_user.id }
    end
    f.actions
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
