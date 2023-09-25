class Api::V0::BookSearchController < ApplicationController
  def index
    location = params[:location]
    quantity = params[:quantity].to_i

    if quantity <= 0
      render json: { error: "Quantity must be a positive integer greater than 0" }, status: :bad_request
      return
    end

    forecast = WeatherFacade.new.get_forecast(location)

    books = LibraryService.new.search_location(location)

    render json: {
      location: location,
      current_weather: forecast[:current_weather],
      total_results: books[:numFound],
      books: books[:docs].take(quantity)
    }
  end
end