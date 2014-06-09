module Staff
  class UsersController < InheritedResources::Base
    before_filter :authenticate_user!
    respond_to :html, only: [:edit, :update]
    def edit
      add_breadcrumb 'my profile', :edit_user_path
    end

    def update
      unless permitted_params[:password].blank?
        current_user.password = permitted_params[:password]
      end
      super
    end

    protected

    def resource
      current_user
    end

    private

    def permitted_params
      params.required(:user).permit(:first_name,
                                    :last_name,
                                    :email,
                                    :password)
    end
  end
end
