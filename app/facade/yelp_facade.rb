class YelpFacade
  def initialize
    @yelp_service = YelpService.new
    @weather_facade = WeatherFacade.new
  end

  def search_businesses(location, cuisine)
    yelp_data = @yelp_service.search_businesses(location, cuisine)
    weather_data = @weather_facade.get_forecast(location)

    {
      yelp: yelp_data,
      weather: weather_data
    }
  end
end