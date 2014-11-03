class Gma::Organization < ActiveRecord::Base
  has_many :gma_staff_reports, dependent: :destroy
  has_many :gma_memberships, dependent: :destroy
  has_many :users, through: :gma_memberships
end
