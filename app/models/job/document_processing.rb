class Job
  class DocumentProcessing < Job
    include Resque::Plugins::Status
    @queue = :statused

    def perform
      self.class.transfer_and_cleanup(options['document_id'])
    end

    # Determines if file requires post-processing (image resizing, etc)
    def post_process_required?(document)
      /^(image|(x-)?application)\/(bm``p|gif|jpeg|jpg|pjpeg|png|x-png)$/
        .match(document.upload_content_type).present?
    end

    # Final upload processing step
    def self.transfer_and_cleanup(id)
      document = Document.find(id)
      direct_upload_url_data = document.url_data
      s3 = AWS::S3.new

      if document.post_process_required?(document)
        document.upload = URI.parse(URI.escape(document.direct_upload_url))
      else
        paperclip_file_path =
          "documents/uploads/#{id}/original/#{direct_upload_url_data[:filename]}"
        s3.buckets[Rails.configuration.aws[:bucket]]
          .objects[document.paperclip_file_path].copy_from(direct_upload_url_data[:path])
      end

      document.processed = true
      document.save

      s3.buckets[Rails.configuration.aws[:bucket]]
        .objects[direct_upload_url_data[:path]].delete
    end
  end
end
