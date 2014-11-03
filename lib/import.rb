require 'resque/errors'

module RetriedJob
  def on_failure_retry(e, *args)
    logger.info "Performing #{self} caused an exception (#{e}). Retrying..."
    $stdout.flush
    Resque.enqueue self, *args
  end
end
