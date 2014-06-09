class GmaMembership < ActiveRecord::Base
  belongs_to :gma_organization
  belongs_to :user
end
