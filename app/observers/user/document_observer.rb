class User
  class DocumentObserver < ActiveRecord::Observer
    def before_create(document, tries = 5)
      document.attributes = document_attributes(document)
    rescue AWS::S3::Errors::NoSuchKey
      tries -= 1
      return false if tries == 0
      sleep(3)
      retry
    end

    def after_create(document)
      Job::DocumentProcessing.create(document_id: document.id)
    end

    protected

    def document_attributes(document)
      data = url_data(document)
      {
        upload_file_name: data[:upload_url_data][:filename],
        upload_file_size: data[:upload_head].content_length,
        upload_content_type: data[:upload_head].content_type,
        upload_updated_at: data[:upload_head].last_modified
      }
    end

    def url_data(document)
      { upload_url_data: document.url_data,
        upload_head:
          AWS::S3.new.buckets[Rails.configuration.aws[:bucket]]
            .objects[document.url_data[:path]].head
      }
    end
  end
end
