class BookSearchSerializer
  def initialize(location, forecast, total_books_found, books)
    @location = location
    @forecast = forecast
    @total_books_found = total_books_found
    @books = books
  end

  def to_json
    {
      data: {
        id: nil,
        type: 'books',
        attributes: {
          destination: @location,
          forecast: {
            summary: @forecast[:current_weather][:condition],
            temperature: "#{@forecast[:current_weather][:temperature]} F"
          },
          total_books_found: @total_books_found,
          books: format_books(@books)
        }
      }
    }
  end

  private

  def format_books(books)
    books.map do |book|
      {
        isbn: book[:isbn],
        title: book[:title]
      }
    end
  end
end