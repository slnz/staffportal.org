module Staff
  module Dmpd
    module Stats
      class AppointmentSetRecordController < InheritedResources::Base
        before_filter :authenticate_user!

        add_breadcrumb 'dmpd', :staff_dmpd_root_path
        add_breadcrumb 'wcs', :staff_dmpd_stats_root_path
        add_breadcrumb 'appointment set record',
                       :staff_dmpd_stats_appointment_set_record_index_path
        def index
          @appointment_set_record =
            current_user.appointment_set_record.order(:date_set)
        end

        def new
          add_breadcrumb \
            'add',
            new_staff_dmpd_stats_appointment_set_record_path(params[:id])
          @appointment_set_record = AppointmentSetRecord.new
          @appointment_set_record.date_set = Time.now.to_date
        end

        def edit
          add_breadcrumb \
            'edit',
            edit_staff_dmpd_stats_appointment_set_record_path(params[:id])
          super
        end

        def create
          create!(notice: 'Nice job adding an appointment set record.') do
            staff_dmpd_stats_appointment_set_record_index_path
          end
        end

        def update
          update!(notice: 'Nice job updating an appointment set record.') do
            staff_dmpd_stats_appointment_set_record_index_path
          end
        end

        protected

        def begin_of_association_chain
          current_user
        end
      end
    end
  end
end
