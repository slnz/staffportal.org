class Gma::StaffReport < ActiveRecord::Base
  default_scope { order('start_date DESC').limit(26) }

  belongs_to :user
  belongs_to :gma_organization

  has_many :gma_measurements
  accepts_nested_attributes_for :gma_measurements

  after_save :gma_update!

  def gma_update!
    update_column(
      :gma_update, Job::GmaUpdateStaffReport.create(gma_staff_report_id: id)
    )
  end

  def gma_update?
    return false if status.nil?
    return false if status.completed? || status.failed?
    true
  end

  def status
    Resque::Plugins::Status::Hash.get(gma_update)
  end
end
