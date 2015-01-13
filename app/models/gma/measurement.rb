class Gma
  class Measurement < ActiveRecord::Base
    self.table_name = 'gma_measurements'
    default_scope { order('id ASC') }
    belongs_to :gma_staff_report, class_name: 'Gma::StaffReport'

    def value
      return self[:value].floor if self[:value].floor.to_d == self[:value]
      super
    end
  end
end
