class Staff::Dmpd::AppointmentSetRecordsController < StaffController
  before_action :authenticate_user!
  add_breadcrumb 'dmpd', :dmpd_root_path
  add_breadcrumb 'appointment set records',
                 :dmpd_appointment_set_records_path

  def index
    load_appointment_set_records
  end

  def show
    load_appointment_set_record
    # add_breadcrumb @appointment_set_record.contact.initials.upcase,
    #                dmpd_appointment_set_record_path(@appointment_set_record)
  end

  def new
    build_appointment_set_record
    add_breadcrumb 'new', :new_dmpd_appointment_set_record_path
  end

  def create
    build_appointment_set_record
    save_appointment_set_record || render('new')
    add_breadcrumb 'new', :new_dmpd_appointment_set_record_path
  end

  def edit
    load_appointment_set_record
    build_appointment_set_record
    # add_breadcrumb @appointment_set_record.initials.upcase,
    #                dmpd_appointment_set_record_path(@appointment_set_record)
    add_breadcrumb 'edit',
                   edit_dmpd_appointment_set_record_path(
                    @appointment_set_record)
  end

  def update
    load_appointment_set_record
    build_appointment_set_record
    save_appointment_set_record || render('edit')
    add_breadcrumb 'edit',
                   edit_dmpd_appointment_set_record_path(
                    @appointment_set_record)
  end

  def destroy
    load_appointment_set_record
    @appointment_set_record.destroy
    redirect_to dmpd_appointment_set_records_path
  end

  protected

  def load_appointment_set_records
    @q ||= apply_scopes(appointment_set_record_scope).search(params[:q])
    @q.sorts = 'first_name asc' if @q.sorts.empty?
    @appointment_set_records ||=
      @q.result(distinct: true).page params[:page]
  end

  def load_appointment_set_record
    @appointment_set_record ||=
      appointment_set_record_scope.find(params[:id])
  end

  def build_appointment_set_record
    @appointment_set_record ||= appointment_set_record_scope.build
    @appointment_set_record.attributes = appointment_set_record_params
  end

  def save_appointment_set_record
    return unless @appointment_set_record.save
    redirect_to [:dmpd, @appointment_set_record]
  end

  def appointment_set_record_scope
    current_user.appointment_set_records
  end

  def appointment_set_record_params
    appointment_set_record_params = params[:appointment_set_record]
    return {} unless appointment_set_record_params
    appointment_set_record_params.permit(
        :contact_id,
        :date_set,
        :date_of_appointment,
        :gift_date,
        :gift_confirmed_date,
        :amount,
        :frequency,
        :number_of_contacts_received,
        :asked_for_contacts,
        :thank_you_posted,
        :notes,
        :address
      )
  end
end
