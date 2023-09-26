require "rails_helper"

RSpec.describe YelpService, :vcr do
  it "connects to the yelpAPI" do
    service = YelpService.new

    expect(service.conn).to be_a(Faraday::Connection)
  end

  it 'returns a hash of business data for pueblo, co' do
    service = YelpService.new

    response = service.search_businesses('pueblo, co', 'italian')

    expect(response).to be_an(Hash)
    expect(response[:businesses]).to be_an(Array)

    if response[:businesses].any?
      business = response[:businesses].first
      expect(business).to have_key(:name)
      expect(business).to have_key(:location)
      expect(business[:location]).to have_key(:display_address)
      expect(business[:location][:display_address]).to be_an(Array)
      expect(business).to have_key(:rating)
      expect(business).to have_key(:review_count)
    end
  end
end






