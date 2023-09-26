class YelpService
  def conn
    api_key = Rails.application.credentials.yelp[:key]
  
    Faraday.new("https://api.yelp.com/v3/businesses/search") do |faraday|
      faraday.headers['Authorization'] = "Bearer #{api_key}"
    end
  end

  def search_businesses(location, cuisine)
    response = conn.get do |req|
      req.params['location'] = location
      req.params['categories'] = cuisine
    end

    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def yelp_api_key
    Rails.application.credentials.yelp[:key]
  end
end