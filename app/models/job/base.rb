module Job
  class Base
    extend Resque::Plugins::Retry
    @retry_limit = 3

    def self.queue
      :low
    end
  end
end