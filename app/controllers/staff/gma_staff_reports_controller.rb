module Staff
  class GmaStaffReportsController < StaffController
    layout 'frame'

    def index
      load_staff_reports
    end

    def edit
      if params[:compare_id]
        @last_staff_report =
          current_user.gma_staff_reports.find(params[:compare_id])
      end
      load_staff_report
    end

    def update
      load_staff_report
      build_staff_report
      save_staff_report
    end

    protected

    def load_staff_reports
      @gma_staff_reports ||= staff_reports_scope
    end

    def load_staff_report
      @gma_staff_report ||= staff_reports_scope.find(params[:id])
    end

    def build_staff_report
      @gma_staff_report ||= staff_reports_scope.build
      @gma_staff_report.attributes = staff_reports_params
    end

    def save_staff_report
      @gma_staff_report.save
    end

    def staff_reports_scope
      current_user.gma_staff_reports.where(
                gma_organization_id: params[:gma_organization_id])
    end

    def user_type
      :statistician
    end

    def staff_reports_params
      return {} unless params[:gma_staff_report]
      Params.permit(params)
    end

    class Params
      def self.permit(params)
        params.require(:gma_staff_report)
              .permit(gma_measurements_attributes: [:value, :id])
      end
    end
  end
end
