ActiveAdmin.register User, namespace: :hr do
  actions :index, :show, :edit, :update
  permit_params :bootcamp_coach_id
  config.filters = false
  index do
    column ('Name') { |user| user.name }
    column :username
    column :bootcamp_coach
    column :contacts, sortable: :contacts_count do |user|
      user.contacts.size
    end
    column ('Tasks') do |user|
      complete = user.user_assignments.
                      where(answer_boolean: true).
                      joins(:assignment).
                      where('assignments.kind = ?', Assignment.kinds[:boolean]).
                      count
      total = Assignment.boolean.count
      tag = :error
      tag = :warn unless complete == 0
      tag = :ok if complete == total
      status_tag("#{complete} / #{total}", tag)
    end
    column ('Essays') do |user|
      complete = user.user_assignments.
                      where('answer_text != \'\'').
                      joins(:assignment).
                      where('assignments.kind = ?', Assignment.kinds[:text]).
                      count
      total = Assignment.text.count
      tag = :error
      tag = :warn unless complete == 0
      tag = :ok if complete == total
      status_tag("#{complete} / #{total}", tag)
    end
    column ('Uploads') do |user|
      complete = user.user_assignments.
                      where('document_id IS NOT NULL').
                      joins(:assignment).
                      where('assignments.kind = ?', Assignment.kinds[:upload]).
                      count
      total = Assignment.upload.count
      tag = :error
      tag = :warn unless complete == 0
      tag = :ok if complete == total
      status_tag("#{complete} / #{total}", tag)
    end
    actions
  end

  form do |f|
    f.inputs 'Details' do
      f.input :bootcamp_coach,
              input_html: { class: 'chosen' },
              include_blank: true,
              label_method: :to_label
    end
    f.actions
  end

  show do |user|
    attributes_table do
      row :name
      row :bootcamp_coach
      row :contacts_count
    end
    render 'tasks'
  end

  controller do
    def scoped_collection
      User.dmpd
    end
  end

end
