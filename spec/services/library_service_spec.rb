require "rails_helper"

describe LibraryService do

  it "searches for books about location", :vcr do
    service = LibraryService.new
    response = service.search_location("Vermont")
    expect(response).to be_a Hash
  end

  it 'returns search results for a location' do
    stub_request(:get, 'https://openlibrary.org/subject/vermont.json')
      .to_return(status: 200, body: '{"numFound": 10, "docs": ["book1", "book2"]}')

    library_service = LibraryService.new
    result = library_service.search_location('vermont')

    expect(result[:numFound]).to eq(10)
    expect(result[:docs]).to eq(["book1", "book2"])
  end

end