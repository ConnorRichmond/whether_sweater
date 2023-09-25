class OpenLibraryService
  BASE_URL = 'https://openlibrary.org/api/v1'.freeze

  def self.book_search(location, quantity)
    response = connection.get("/book-search?location=#{location}&quantity=#{quantity}")
    handle_response(response)
  end

  private

  def self.connection
    Faraday.new(url: BASE_URL)
  end

  def self.handle_response(response)
    if response.status == 200
      JSON.parse(response.body)
    else
      nil 
    end
  end
end