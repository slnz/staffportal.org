class Gma::Measurement < ActiveRecord::Base
  default_scope { order('id ASC') }
  belongs_to :gma_staff_report

  def value
    return self[:value].floor if self[:value].floor.to_d == self[:value]
    super
  end
end
