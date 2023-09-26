class Api::V0::MunchieController < ApplicationController
  def show
    location = params[:destination]
    cuisine = params[:food]

    # Initialize the YelpService
    yelp_service = YelpService.new

    # Make the API request to Yelp
    yelp_data = yelp_service.search_businesses(location, cuisine)

    # Process the Yelp data and build the response
    response_data = {
      destination_city: location,
      forecast: {
        summary: 'Your summary here', # Replace with actual forecast data
        temperature: 'Your temperature here' # Replace with actual forecast data
      },
      restaurant: {
        name: yelp_data[:name], # Extract relevant data from Yelp response
        address: yelp_data[:address], # Extract relevant data from Yelp response
        rating: yelp_data[:rating], # Extract relevant data from Yelp response
        reviews: yelp_data[:reviews] # Extract relevant data from Yelp response
      }
    }

    render json: MunchieSerializer.new(response_data).to_json
  end
end