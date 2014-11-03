class Staff::GmaStaffReportsController < StaffController
  inherit_resources

  layout 'frame'
  belongs_to :gma_organization
  before_action :authenticate_user!

  def index
    @gma_staff_reports =
      current_user.gma_staff_reports.where(
        gma_organization_id: params[:gma_organization_id]).all
  end

  def edit
    if params[:compare_id]
      @last_staff_report =
        current_user.gma_staff_reports.find(params[:compare_id])
    end
    super
  end

  def update
    resource.update(permitted_params)
  end

  protected

  def begin_of_association_chain
    current_user
  end

  def permitted_params
    params.require(:gma_staff_report)
           .permit(gma_measurements_attributes: [:value, :id])
  end
end
