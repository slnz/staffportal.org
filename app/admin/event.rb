ActiveAdmin.register Event do
  permit_params :name, :description, :additional_information,
                :speaker_description, :start_date, :finish_date, :adult_cost,
                :teen_cost, :child_cost, :address, :teens_can_attend,
                :children_can_attend, :logo_id, :programme_id,
                :venue_id, :speaker_id, :information_id,
                :registration_information

  index do
    selectable_column
    column :name
    column :description
    column :start_date
    column :finish_date
    actions
  end

  action_item :download, only: :show do
    link_to 'Download Registrations', action: 'download'
  end

  member_action :download, method: :get do
    event = Event.find(params[:id])
    registrations = event.registrations
    attendee_fields = %w(first_name last_name primary_phone email medical_requirements dietary_requirements
                         emergency_contact_name emergency_contact_relationship emergency_contact_phone address)
    registration_fields = %w(comments)
    csv = CSV.generate(encoding: 'Windows-1251') do |csv_data|
      csv_data << attendee_fields + registration_fields
      registrations.each do |registration|
        attendee = registration.user.try(:decorate)
        csv_line = []
        attendee_fields.each do |field|
          csv_line += [attendee.send(field)]
        end
        registration_fields.each do |field|
          csv_line += [registration.send(field)]
        end
        csv_data << csv_line
      end
    end
    send_data csv.encode('Windows-1251'),
              type: 'text/csv; charset=windows-1251; header=present',
              disposition: "attachment; filename=#{event.name.parameterize.underscore}_attendees.csv"
  end

  form do |f|
    f.inputs title: 'Event Core Details' do
      f.input :logo
      f.input :name
      f.input :description
      f.input :start_date
      f.input :finish_date
    end
    f.inputs title: 'About' do
      f.input :information
      f.input :additional_information
    end
    f.inputs title: 'Pricing' do
      f.input :adult_cost
      f.input :teens_can_attend
      f.input :teen_cost
      f.input :children_can_attend
      f.input :child_cost
    end
    f.inputs title: 'Speaker' do
      f.input :speaker
      f.input :speaker_description
    end
    f.inputs title: 'Venue' do
      f.input :address
      f.input :venue
    end
    f.inputs title: 'Programme' do
      f.input :programme
    end
    f.inputs title: 'Registration' do
      f.input :registration_information
    end
    f.actions
  end
end
