class Gma
  class Membership < ActiveRecord::Base
    self.table_name = 'gma_memberships'
    belongs_to :gma_organization, class_name: 'Gma::Organization'
    belongs_to :user
  end
end
