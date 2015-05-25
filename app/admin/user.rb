ActiveAdmin.register User do
  decorate_with UserDecorator
  config.sort_order = 'id_asc'

  scope :admins
  scope :account_holders
  scope :contacts
  scope :statisticians
  scope :players
  scope :attendees

  filter :first_name
  filter :last_name
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :id
    column :first_name
    column :last_name
    column :email
    column('Role') { |u| status_tag('Admin', 'orange') if u.admin? }
    actions
  end

  form do |f|
    f.inputs title: 'User' do
      f.input :first_name
      f.input :last_name
      f.input :username
    end
    f.actions
  end

  show do
    attributes_table do
      row :first_name
      row :last_name
      row :email
    end
  end

  permit_params :first_name, :last_name, :email
end
