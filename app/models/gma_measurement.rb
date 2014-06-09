class GmaMeasurement < ActiveRecord::Base
  default_scope { order('id ASC') }
  belongs_to :gma_staff_report

  def value
    if read_attribute(:value).floor.to_d == read_attribute(:value)
      read_attribute(:value).floor
    else
      read_attribute(:value)
    end
  end
end
