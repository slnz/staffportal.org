ActiveAdmin.register User, :namespace => :coach do
  scope_to :current_user, :association_method => :trainees
  actions :index, :show
  config.filters = false
  index do
    column ("Name") { |user| user.name }
    column ("Latest CCB") { |user| status_tag user.contact_card_box.last.created_at_print unless user.contact_card_box.last.nil? }
    column ("Latest WCC") { |user| status_tag user.support_raising_developments.last.created_at_print unless user.support_raising_developments.last.nil? }
    column ("Latest ASR") { |user| status_tag user.appointment_set_record.last.created_at_print unless user.appointment_set_record.last.nil? }
    default_actions
  end

  show :title => :name do |user|
    attributes_table do
      row :name
      row :username
      row :currency
      row("admin") { |user| status_tag(user.admin, "orange") }
    end

    panel "Contacts" do
      table_for(user.contacts) do
        column :name
        column :phone
      end
    end
  end
end
