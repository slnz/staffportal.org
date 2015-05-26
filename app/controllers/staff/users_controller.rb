module Staff
  class UsersController < StaffController
    add_breadcrumb 'directory', :users_path

    def index
      load_users
      decorate_users
    end

    def show
      load_user
      decorate_user
      add_breadcrumb @user.name, :user_path
    end

    def edit
      load_current_user
      decorate_user
      build_user
      add_breadcrumb 'my profile', :edit_user_path
    end

    def update
      load_current_user
      build_user
      return flash[:success] = 'Successfully updated your profile' if save_user
      decorate_user
      flash.now[:error] = 'There was a problem updating your profile'
      add_breadcrumb 'my profile', :edit_user_path
      render action: :edit
    end

    protected

    def load_users
      @q ||= apply_scopes(user_scope).search(params[:q])
      @q.sorts = 'first_name asc' if @q.sorts.empty?
      @users ||= @q.result(distinct: true).page params[:page]
    end

    def decorate_users
      @users = @users.try(:decorate)
    end

    def load_user
      @user ||= user_scope.find(params[:id])
    end

    def load_current_user
      @user ||= current_user
    end

    def decorate_user
      @user = @user.try(:decorate)
    end

    def build_user
      @user ||= user_scope
      @user.attributes = user_params
    end

    def save_user
      redirect_to action: :edit if @user.save
    end

    def user_scope
      User.where('roles_mask & ? = ?',
                 User.mask_for(:contact),
                 User.mask_for(:contact))
    end

    def user_type
      :contact
    end

    def user_params
      user_params = params[:user]
      return {} unless user_params
      user_params.permit(:first_name,
                         :last_name,
                         :email,
                         :password,
                         :primary_phone,
                         :home_phone,
                         :office_phone,
                         :address,
                         :ministry_id,
                         :dietary_requirements,
                         :medical_requirements,
                         :emergency_contact_phone,
                         :emergency_contact_name,
                         :emergency_contact_relationship,
                         kids_attributes: [
                           :id,
                           :first_name,
                           :last_name,
                           :dietary_requirements,
                           :medical_requirements,
                           :comments,
                           :toileting_assistance,
                           :activity_limitations,
                           :swimming_capability,
                           :date_of_birth,
                           :outings,
                           :media_waiver,
                           :_destroy])
    end
  end
end
