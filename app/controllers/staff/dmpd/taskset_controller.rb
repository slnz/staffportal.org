module Staff
  module Dmpd
    class TasksetController < InheritedResources::Base
      before_filter :authenticate_user!

      add_breadcrumb 'dmpd', :staff_dmpd_root_path
      def edit
        @taskset = Taskset.find(params[:id])
        add_breadcrumb @taskset.name, edit_staff_dmpd_taskset_path(params[:id])
      end

      def permitted_params

      end
    end
  end
end
