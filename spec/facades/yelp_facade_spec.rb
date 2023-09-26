require 'rails_helper'

RSpec.describe YelpFacade, :vcr do
  it "fetches Yelp and weather data for a location" do
    facade = YelpFacade.new
    location = "pueblo, co"
    cuisine = "italian"

    data = facade.search_businesses(location, cuisine)

    expect(data).to be_a(Hash)
    expect(data).to have_key(:yelp)
    expect(data[:yelp]).to be_a(Hash)
    expect(data).to have_key(:weather)
    expect(data[:weather]).to be_a(Hash)
  end
end