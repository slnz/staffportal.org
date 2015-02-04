module Staff
  class GmaOrganizationsController < StaffController
    add_breadcrumb 'my statistics', :gma_organizations_path

    def index
      if current_user.gma_update?
        @status = current_user.status
        render 'busy'
      else
        load_gma_organizations
      end
    end

    protected

    def load_gma_organizations
      @gma_organizations ||= gma_organizations_scope
    end

    def gma_organizations_scope
      current_user.gma_organizations
    end

    def user_type
      :statistician
    end
  end
end
