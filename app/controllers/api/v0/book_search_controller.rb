class Api::V0::BookSearchController < ApplicationController
  before_action :validate_location
  before_action :validate_quantity
  rescue_from ActionController::BadRequest, with: :error_response

  def index 
    forecast = WeatherFacade.new.get_forecast(params[:location])
    book_results = BookSearchFacade.new.find_books(search_params)
    render json: BookSearchSerializer.new(forecast, book_results).to_json
  end

  # def index
  #   location = params[:location]
  #   quantity = params[:quantity].to_i
  
  #   if quantity <= 0
  #     render json: { error: 'Quantity must be a positive integer greater than 0' }, status: :bad_request
  #     return
  #   end
  
  #   forecast = WeatherFacade.new.get_forecast(location)
  
  #   books = LibraryService.new.search_location(location)
  
  #   # check if api consumption issue
  #   if books.nil? || !books.key?(:numFound) || !books.key?(:docs)
  #     render json: { error: 'Failed to retrieve book search results' }, status: :internal_server_error
  #     return
  #   end
  
  #   render json: BookSearchSerializer.new(location, forecast, books[:numFound], books[:docs].take(quantity)).to_json
  # end

  private 

  def search_params
    params.permit(:location, :quantity)
  end

  def validate_quantity 
    unless params[:quantity].to_i > 0
      raise ActionController::BadRequest.new("Quantity must be a number greater than 0")
    end
  end

  def validate_location 
    unless params[:location]
      raise ActionController::BadRequest.new("Location cannot be blank")
    end
  end

  def error_response(error)
    render json: {message: error.message}, status: :unprocessable_entity
  end
end