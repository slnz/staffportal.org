ActiveAdmin.register User::Permission, as: 'Permission' do
  decorate_with User::PermissionDecorator
  menu parent: 'Accounts'
  permit_params :user_id, :account_id, :by_id
  index do
    selectable_column
    column :user
    column :account
    column :by
    actions
  end

  form decorate: true do |f|
    f.inputs 'Details' do
      f.input :user, input_html: { class: 'chosen' }, collection: User.all.decorate
      f.input :account,
              input_html: { class: 'chosen' },
              include_blank: true,
              collection: Account.all.decorate
      f.input :by_id, as: :hidden, input_html: { value: current_user.id }
    end
    f.actions
  end

  show do
    attributes_table do
      row :user
      row :account
      row :by
    end
  end

  filter :user, as: :select, collection: proc { User.all.decorate }
  filter :account, as: :select, collection: proc { Account.all.decorate }
  filter :by, as: :select, collection: proc { User.all.decorate }
end
