class Job
  class GmaUpdateStaffReport < Job
    include Resque::Plugins::Status
    def perform
      publish(GmaStaffReport.find(options['gma_staff_report_id']))
    end
  end
end
