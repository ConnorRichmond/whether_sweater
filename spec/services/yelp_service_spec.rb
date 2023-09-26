require "rails_helper"

RSpec.describe YelpService, :vcr do
  it 'returns a hash of business data' do
    location = 'new york, ny'
    cuisine = 'italian'

    yelp_service = YelpService.new

    response = yelp_service.search_businesses(location, cuisine)

    expect(response).to be_a(Hash)
    expect(response[:businesses]).to be_an(Array)
    expect(response[:businesses].first).to have_key(:name)
    expect(response[:businesses].first).to have_key(:address)
    expect(response[:businesses].first).to have_key(:rating)
    expect(response[:businesses].first).to have_key(:reviews)
  end
end