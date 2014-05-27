module Staff
  module Dmpd
    class Week2Controller < InheritedResources::Base
      respond_to :html, only: [:show, :edit, :update]
      before_filter :authenticate_user!
      def show
        redirect_to staff_dmpd_root_path, notice: 'Saved Taskset 5'
      end

      def edit
        add_breadcrumb 'dmpd', :staff_dmpd_root_path
        add_breadcrumb 'taskset 5', edit_staff_dmpd_week2_path(params[:id])
        super
      end
    end
  end
end
