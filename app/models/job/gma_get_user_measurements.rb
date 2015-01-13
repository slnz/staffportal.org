class Job
  class GmaGetUserMeasurements < Job
    include Resque::Plugins::Status
    include Job::Concerns::GmaApi

    def perform
      import_user(User.find(options['user_id']))
    end
  end
end
