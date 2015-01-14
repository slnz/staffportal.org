module Staff
  module Dmpd
    class TasksetController < StaffController
      before_action :authenticate_user!

      add_breadcrumb 'dmpd', :dmpd_path
      add_breadcrumb 'tasksets', :dmpd_taskset_index_path

      def index
        @tasksets = ::Dmpd::Taskset.order(:due_week).all
      end

      def edit
        @taskset = ::Dmpd::Taskset.find(params[:id])
        add_breadcrumb @taskset.name, edit_dmpd_taskset_path(params[:id])
      end

      def update
        permitted_params[:dmpd_taskset][:assignments_attributes]
          .try(:each) do |_id, new_assignment|
          update_assignment = new_assignment[:user_assignments_attributes]['0']
          current_user_assignment = current_user.user_assignments
                                    .find(update_assignment[:id])
          answer_key = update_assignment.keys[0]
          current_user_assignment.update_attributes(
            answer_key => update_assignment[answer_key]
          )
        end
        redirect_to dmpd_taskset_index_path
        flash[:success] = 'Taskset Updated'
      end

      private

      def permitted_params
        params.permit(dmpd_taskset:
          [assignments_attributes:
            [user_assignments_attributes:
              [:answer_boolean, :answer_text, :document_id, :id]
            ]
          ]
        )
      end

      def current_user
        super.as(:trainee)
      end
    end
  end
end
