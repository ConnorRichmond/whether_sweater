class LibraryService
  def conn
    Faraday.new(url: "https://openlibrary.org/")
  end

  def get_url(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

  def search_location(location)
    url = "subject/#{location}.json"
    get_url(url)
  end
end