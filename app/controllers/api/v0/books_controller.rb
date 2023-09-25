class BooksController < ApplicationController
  def index
    location = params[:location] || 'denver,co'
    quantity = params[:quantity] || 5

    data = OpenLibraryService.book_search(location, quantity)

    if data
      render json: BookSearchSerializer.new(data).serialized_json
    else
      render json: { error: 'Failed to fetch data from Open Library API' }, status: :bad_request
    end
  end
end