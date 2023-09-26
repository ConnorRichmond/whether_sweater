require "rails_helper"

RSpec.describe "Munchies API", :vcr do
  it "returns a JSON response with restaurant and forecast data" do
    get "/api/v0/munchie", params: { location: "pueblo,co", cuisine: "italian" }

    expect(response).to be_successful
    expect(response.status).to eq(200)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:destination_city)
    expect(response_data).to have_key(:forecast)
    expect(response_data).to have_key(:restaurant)
  end
end