class MunchieSerializer
  def initialize(yelp_data, weather_data)
    @yelp_data = yelp_data
    @weather_data = weather_data
  end

  def to_json
    {
      data: {
        id: nil,
        type: "munchie",
        attributes: {
          destination_city: @yelp_data[:destination_city],
          forecast: {
            summary: @weather_data[:summary],
            temperature: @weather_data[:temperature]
          },
          restaurant: {
            name: @yelp_data[:restaurant][:name],
            address: @yelp_data[:restaurant][:address],
            rating: @yelp_data[:restaurant][:rating],
            reviews: @yelp_data[:restaurant][:reviews]
          }
        }
      }
    }
  end
end