class Gma
  def self.import_user(user, auth = false)
    auth = authenticate(user) if auth == false
    unless auth == false
      response =
        HTTParty.get("#{ENV['GMA_URL']}",
                     query: { q: 'gmaservices/gma_user',
                              type: 'current' },
                     headers: { 'X-CSRF-Token' => auth[:token],
                                'Cookie' => auth[:cookie] })

      gma_user = JSON.parse(response.body)

      return unless gma_user['success']

      user.update_attribute :gma_id, gma_user['data'].first['renId']

      response =
        HTTParty.get("#{ENV['GMA_URL']}",
                     query:
                       { q: "gmaservices/gma_user/#{user.gma_id}/assignments" },
                     headers: { 'X-CSRF-Token' => auth[:token],
                                'Cookie' => auth[:cookie] }
                    )

      gma_orgs = JSON.parse(response.body)

      return unless gma_orgs['success']

      gma_orgs['data']['director'].each do |gma_org|
        db_gma_org =
          GmaOrganization.where(gma_id: gma_org['nodeId']).first_or_create
        db_gma_org.update_attribute :name, gma_org['shortName']

        GmaMembership.where(user: user,
                            gma_organization: db_gma_org,
                            director: true).first_or_create
      end unless gma_orgs['data']['director'].nil?

      gma_orgs['data']['staff'].each do |gma_org|
        db_gma_org =
          GmaOrganization.where(gma_id: gma_org['nodeId']).first_or_create
        db_gma_org.update_attribute :name, gma_org['shortName']

        GmaMembership.where(user: user,
                            gma_organization: db_gma_org).first_or_create
      end unless gma_orgs['data']['staff'].nil?

      response =
        HTTParty.post("#{ENV['GMA_URL']}",
                      query: { q: 'gmaservices/gma_staffReport/searchOwn' },
                      body: { 'maxResult' => 0 }.to_json,
                      headers: { 'X-CSRF-Token' => auth[:token],
                                 'Cookie' => auth[:cookie],
                                 'Content-Type' => 'application/json' })

      gma_reports = JSON.parse(response.body)

      return unless gma_reports['success']

      gma_reports['data']['staffReports'].each do |gma_report|
        db_gma_org =
          GmaOrganization.where(
            gma_id: gma_report['node']['nodeId']).first_or_create
        db_gma_org.update_attribute :name, gma_report['node']['shortName']

        db_gma_report =
          GmaStaffReport.where(gma_id: gma_report['staffReportId'],
                               gma_organization_id: db_gma_org.id,
                               user_id: user.id).first_or_create

        db_gma_report.update(
          user_id: user.id,
          gma_organization_id: db_gma_org.id,
          version: gma_report['version'],
          submitted: gma_report['submitted'],
          start_date: Date.strptime(gma_report['startDate'], '%Y%m%d'),
          end_date: Date.strptime(gma_report['endDate'], '%Y%m%d')
        )

        response =
          HTTParty.get("#{ENV['GMA_URL']}",
                       query: {
                         q:
                           "gmaservices/gma_staffReport/#{db_gma_report.gma_id}"
                       },
                       headers: { 'X-CSRF-Token' => auth[:token],
                                  'Cookie' => auth[:cookie] })

        gma_measurements = JSON.parse(response.body)

        break unless gma_measurements['success']

        gma_measurements['data']['numericMeasurements'].each do |hash|
          hash.each do |strategy, measurements|
            measurements.each do |measurement|
              db_measurement =
                GmaMeasurement.where(gma_id: measurement['measurementId'],
                                     gma_organization_id: db_gma_org.id,
                                     gma_staff_report_id:
                                       db_gma_report.id).first_or_create
              db_measurement.update(name: measurement['measurementName'],
                                    description:
                                      measurement['measurementDescription'],
                                    value: measurement['measurementValue'],
                                    strategy: strategy)
            end
          end
        end unless gma_measurements['data']['numericMeasurements'].nil?
      end unless gma_reports['data']['staffReports'].nil?
    end
  end

  def self.authenticate(user)
    # Rails Implementation

    # login to CAS
    response = HTTParty.post('https://thekey.me/cas/v1/tickets',
                             body: { username: user.email,
                                     password: user.password })

    # parse tgt
    target_url = response.header['location']

    # return if login failure
    return false if response.code != 201 || target_url.blank?

    # get ST
    response =
      HTTParty.post(target_url,
                    body:
                      { service: "#{ENV['GMA_URL']}?q=node&destination=node" })

    # parse ticket
    ticket = response.body

    # return if ticket failure
    return false if response.code != 200 || ticket.blank?

    # use ST w/ GMA (follow redirects & capture cookies)
    response =
      HTTParty.get("#{ENV['GMA_URL']}?q=node&destination=node&ticket=#{ticket}")

    # extract the correct Set-Cookie header
    cookie = response.request.options[:headers]['Cookie']

    response =
      HTTParty.get("#{ENV['GMA_URL']}?q=services/session/token",
                   headers: { 'Cookie' => cookie })

    return false unless response.code == 200

    # return session established successfully
    { token: response.body, cookie: cookie }
  end
end
