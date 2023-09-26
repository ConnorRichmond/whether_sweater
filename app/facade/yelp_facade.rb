class YelpFacade
  def initialize(api_key)
    @api_key = api_key
  end

  def get_event(event_id)
    response = yelp_api.get("/events/#{event_id}")
    if response.success?
      JSON.parse(response.body)
    else
      nil
    end
  end

  private

  def yelp_api
    @connection ||= Faraday.new(url: 'https://api.yelp.com/v3') do |faraday|
      faraday.request :url_encoded
      faraday.adapter Faraday.default_adapter

      faraday.headers['Authorization'] = "Bearer #{@api_key}"
      faraday.headers['Accept'] = 'application/json'
    end
  end
end