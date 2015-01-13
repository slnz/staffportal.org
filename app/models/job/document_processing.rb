class Job
  class DocumentProcessing < Job
    include Resque::Plugins::Status
    @queue = :statused

    def perform
      Document.transfer_and_cleanup(options['document_id'])
    end
  end
end
