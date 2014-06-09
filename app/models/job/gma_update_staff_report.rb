module Job
  class GmaUpdateStaffReport < Job::Base
    include Resque::Plugins::Status
    include Job::Concerns::GmaApi

    def perform
      publish(GmaStaffReport.find(options['gma_staff_report_id']))
    end
  end
end