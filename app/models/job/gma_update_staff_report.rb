class Job::GmaUpdateStaffReport < Job
  include Resque::Plugins::Status
  include Job::Concerns::GmaApi

  def perform
    publish(GmaStaffReport.find(options['gma_staff_report_id']))
  end
end
