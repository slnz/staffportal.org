ActiveAdmin.register User, :namespace => :coach do
  scope_to :current_user, :association_method => :trainees
  actions :index, :show
  config.filters = false
  index do
    column ("Name") { |user| user.name }
    column ("Latest CCB") { |user| user.contact_card_box.last.created_at_print unless user.contact_card_box.last.nil? }
    column ("Latest WCC") { |user| user.support_raising_developments.last.created_at_print unless user.support_raising_developments.last.nil? }
    column ("Latest ASR") { |user| user.appointment_set_record.last.created_at_print unless user.appointment_set_record.last.nil? }
    default_actions
  end

  show :title => :name do |user|
    attributes_table do
      row :name
      row :username
      row :currency
      row("admin") { |user| status_tag(user.admin, "orange") }
    end

    panel "Statistics Summary" do
      @weeks = Week.where('date_finished < ?', Time.now.to_date + 1.week)
      render :partial => "stats", :locals => { :@weeks => @weeks, user: user }
    end

    panel "Contact Card Box" do
      table_for(user.contact_card_box, :class => "ccbs") do
        column :week, title: "Week Ending", :html => { :th => { :class => "gray" }, :td => { :class => "gray" }} do |ccb|
          ccb.week.end_name
        end
        column :contact_cards
        column :not_back_until
        column :office_phone_only
        column :contact_total, :class => "orange"
        column "CB Appt", :call_back_for_appointment
        column "CB Decision", :call_back_for_decision
        column "CB Contacts", :call_back_for_contacts
        column :call_back_total, :class => "orange"
        column "Appt Set", :appointment_set
        column "No Appt", :called_no_appointment_set
        column "Appt No Sup", :appointment_no_support
        column "New MP", :new_ministry_partner
        column "Appt Total", :appointment_total, :class => "orange"
        column "CBY", :call_back_in_a_year
        column :would_have_met
        column "OL", :on_list
        column :future_total, :class => "orange"
        column "mpm", :maintainance
        column "mpm done", :maintainance_done
        column :mpm_total, :class => "orange"
        column :total, :class => "orange"
      end
    end

    panel "Weekly Calling Chart" do
      table_for(user.support_raising_developments) do
        column :week, title: "Week Ending", :html => { :th => { :class => "gray" }, :td => { :class => "gray" }} do |wcc|
          wcc.week.end_name
        end
        column :appointments_asked_for
        column :contacts_asked_for
        column :number_of_calls_made
        column :hours_calling
      end
    end

    panel "Appointment Set Record" do
      table_for(user.appointment_set_record) do
        column :name, :class => "week"
        column :date_set
        column "Appt Date", :date_of_appointment
        column :gift_date
        column "Confirmed", :gift_confirmed_date
        column "Amount", :pretty_amount
        column "# Contacts", :number_of_contacts_received
        column "Asked for Contacts", :asked_for_contacts do |bool|
          if bool then "Yes" else "No" end
        end
        column :thank_you_posted, title: "TY Posted" do |bool|
          if bool then "Yes" else "No" end
        end
      end
    end

    panel "Contact Ratio" do
      @weeks = Week.where('date_finished < ?', Time.now.to_date + 1.week)
      render :partial => "contacts", :locals => { :@weeks => @weeks, user: user }
    end
  end
end
