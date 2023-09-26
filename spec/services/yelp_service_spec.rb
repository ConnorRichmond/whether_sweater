require "rails_helper"

RSpec.describe YelpService, :vcr do
  it 'connects to the Yelp API' do
    service = YelpService.new

    expect(service.conn).to be_a(Faraday::Connection)
  end

  it 'returns a hash of business data' do
    service = YelpService.new

    response = service.search_businesses('new york, ny', 'italian')

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data).to have_key(:businesses)
    expect(data[:businesses]).to be_an(Array)

    if data[:businesses].any?
      expect(data[:businesses].first).to have_key(:name)
      expect(data[:businesses].first).to have_key(:location)
      expect(data[:businesses].first[:location]).to have_key(:address)
      expect(data[:businesses].first).to have_key(:rating)
      expect(data[:businesses].first).to have_key(:review_count)
    end
  end
end