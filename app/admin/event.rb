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
