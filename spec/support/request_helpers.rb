module Requests
  module ApiHelpers
    def json
      @json ||= JSON.parse(response.body)
    end

    def authenticate(app, params = {})
      { access_id: app.access_id,
        access_secret: app.access_secret }.merge(params)
    end
  end
end
