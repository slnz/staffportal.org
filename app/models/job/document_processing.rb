class Job
  class DocumentProcessing < Job
    include Resque::Plugins::Status
    @queue = :statused

    def perform
      load_document
      return if @document.processed?
      load_s3_bucket
      load_url_data
      transfer_document
      cleanup_s3
      cleanup_document
    end

    private

    def load_document
      @document ||= User::Document.find(options['document_id'])
    end

    def load_s3_bucket
      @s3_bucket ||= AWS::S3.new.buckets[Rails.configuration.aws[:bucket]]
    end

    def load_url_data
      @url_data ||= @document.url_data
    end

    def transfer_document
      if post_process_required?
        return @document.upload =
          URI.parse(URI.escape(@document.direct_upload_url))
      end
      @document.paperclip_file_path =
        "documents/uploads/#{id}/original/#{@url_data[:filename]}"
    end

    def cleanup_s3
      @s3_bucket.objects[@document.paperclip_file_path]
        .copy_from(@url_data[:path])
      @s3_bucket.objects[@url_data[:path]].delete
    end

    def cleanup_document
      @document.processed = true
      @document.save
    end

    def post_process_required?
      /^(image|(x-)?application)\/(bm``p|gif|jpeg|jpg|pjpeg|png|x-png)$/
        .match(@document.upload_content_type).present?
    end
  end
end
