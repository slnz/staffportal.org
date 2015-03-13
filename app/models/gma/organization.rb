class Gma
  class Organization < ActiveRecord::Base
    self.table_name = 'gma_organizations'
    has_many :gma_staff_reports,
             dependent: :destroy,
             class_name: 'Gma::StaffReport',
             foreign_key: :gma_organization_id
    has_many :gma_memberships,
             dependent: :destroy,
             class_name: 'Gma::Membership',
             foreign_key: :gma_organization_id
    has_many :users, through: :gma_memberships
  end
end
