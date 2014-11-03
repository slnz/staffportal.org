class Staff::UsersController < StaffController
  def edit
    load_user
    build_user
    add_breadcrumb 'my profile', :edit_user_path
  end

  def update
    load_user
    build_user
    save_user || render('edit')
    add_breadcrumb 'my profile', :edit_user_path
  end

  protected

  def load_user
    @user ||= user_scope
  end

  def build_user
    @user ||= user_scope
    @user.attributes = user_params
  end

  def save_user
    return unless @user.save
    redirect_to authenticated_root_path
  end

  def user_scope
    current_user
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
                       :address)
  end
end
