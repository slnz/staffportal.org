module Staff
  class GmaOrganizationsController < InheritedResources::Base
    before_filter :authenticate_user!

    def index
      if current_user.gma_update?
        @status = current_user.status
        render 'busy'
      else
        super
      end
    end

    protected

    def begin_of_association_chain
      current_user
    end
  end
end
