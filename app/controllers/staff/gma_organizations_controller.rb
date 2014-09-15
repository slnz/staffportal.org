module Staff
  class GmaOrganizationsController < InheritedResources::Base
    before_filter :authenticate_user!

    add_breadcrumb 'my statistics', :gma_organizations_path

    def index
      if current_user.stats?
        if current_user.gma_update?
          @status = current_user.status
          render 'busy'
        else
          super
        end
      else
        render 'signup'
      end
    end

    def signup
      current_user.stats = true
      current_user.save!
      redirect_to action: :index
    end

    protected

    def begin_of_association_chain
      current_user
    end
  end
end
