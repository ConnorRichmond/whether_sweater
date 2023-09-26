class Api::V0::MunchieController < ApplicationController
  def show
    location = params[:destination]
    cuisine = params[:food]

    coordinates = MapquestFacade.new.coordinates(location)

    if coordinates.present?
      lat = coordinates[:lat]
      lng = coordinates[:lng]
      weather_data = WeatherFacade.new.get_forecast(lat, lng)
      yelp_data = YelpFacade.new.search_businesses(location, cuisine)

      response_data = {
        destination_city: location,
        forecast: {
          summary: weather_data[:summary],
          temperature: weather_data[:temperature]
        },
        restaurant: {
          name: yelp_data[:name],      
          address: yelp_data[:address],
          rating: yelp_data[:rating],
          reviews: yelp_data[:reviews]
        }
      }

      render json: MunchieSerializer.new(response_data).to_json
    else
      render json: { error: "Invalid location" }, status: :bad_request
    end
  end
end