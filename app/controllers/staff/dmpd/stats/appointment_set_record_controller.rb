class Staff::Dmpd::Stats::AppointmentSetRecordController < InheritedResources::Base
  before_filter :authenticate_user!

  def index
		@appointment_set_record = current_user.appointment_set_record
  end

	def new
		@appointment_set_record = AppointmentSetRecord.new
		@appointment_set_record.date_set = Time.now.to_date
	end

	def create
		create!(:notice => "Dude! Nice job adding an appointment set record.") { staff_dmpd_stats_appointment_set_record_index_path }
	end

	def update
		update!(:notice => "Dude! Nice job updating an appointment set record.") { staff_dmpd_stats_appointment_set_record_index_path }
	end

  protected
    def begin_of_association_chain
      current_user
    end
end