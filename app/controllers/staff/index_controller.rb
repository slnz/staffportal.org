module Staff
  class IndexController < StaffController
    def index
    end

    def roadblock
      if Roadblock.where('created_at > ?', current_user.last_sign_in_at).exists?
        @rb = Roadblock.where('created_at > ?', current_user.last_sign_in_at)
                  .order('created_at')
                  .last
        render layout: 'signed_out'
      else
        redirect_to root_path
      end
    end
  end
end
