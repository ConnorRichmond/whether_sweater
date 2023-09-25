require "rails_helper"

describe LibraryService do

  it "searches for books about location", :vcr do
    service = LibraryService.new
    response = service.search_location("Vermont")
    expect(response).to be_a Hash
  end

end