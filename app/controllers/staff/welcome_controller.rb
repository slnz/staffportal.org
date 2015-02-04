module Staff
  class WelcomeController < StaffController
    def index
      render "index#{params[:stage].to_i}"
    end
  end
end
