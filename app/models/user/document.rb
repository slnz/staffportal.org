class User
  class Document < ActiveRecord::Base
    DIRECT_UPLOAD_URL_FORMAT =
      %r{\A#{Regexp.escape Rails.configuration.aws[:url]}(?<path>uploads\/.+\/(?<filename>.+))\z}.freeze

    belongs_to :user
    has_many :user_assignments, dependent: :nullify, class_name: 'User::Assignment'
    has_attached_file :upload
    do_not_validate_attachment_file_type :upload

    validates :direct_upload_url,
              presence: true,
              format: { with: DIRECT_UPLOAD_URL_FORMAT }

    def name
      upload_file_name
    end

    def direct_upload_url=(escaped_url)
      self[:direct_upload_url] = CGI.unescape(escaped_url)
    rescue
      nil
    end

    def url_data
      DIRECT_UPLOAD_URL_FORMAT.match(direct_upload_url)
    end
  end
end
