class Job
  class GmaUpdateStaffReport < Job
    include Resque::Plugins::Status
    include Job::Concerns::GmaApi

    def perform
      publish(Gma::StaffReport.find(options['gma_staff_report_id']))
    end
  end
end
