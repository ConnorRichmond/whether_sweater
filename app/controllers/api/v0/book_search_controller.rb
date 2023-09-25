class Api::V0::BookSearchController < ApplicationController
  def index
    location = params[:location]
    quantity = params[:quantity].to_i
  
    if quantity <= 0
      render json: { error: 'Quantity must be a positive integer greater than 0' }, status: :bad_request
      return
    end
  
    forecast = WeatherFacade.new.get_forecast(location)
  
    books = LibraryService.new.search_location(location)
  
    # check if api consumption issue
    if books.nil? || !books.key?(:numFound) || !books.key?(:docs)
      render json: { error: 'Failed to retrieve book search results' }, status: :internal_server_error
      return
    end
  
    render json: BookSearchSerializer.new(location, forecast, books[:numFound], books[:docs].take(quantity)).to_json
  end
end