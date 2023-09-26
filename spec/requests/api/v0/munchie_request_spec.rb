require 'rails_helper'

RSpec.describe "Munchies API", type: :request do
  describe "GET /api/v0/munchies" do
    it "returns a JSON response with restaurant and forecast data", vcr: { cassette_name: 'munchies_api' } do
      destination = 'pueblo, pO'
      cuisine = 'italian'

      get "/api/v0/munchies", params: { destination: destination, cuisine: cuisine }

      expect(response).to have_http_status(:success)
      expect(response.content_type).to eq('application/json; charset=utf-8')

      json_response = JSON.parse(response.body)
      expect(json_response).to have_key('data')

      data = json_response['data']
      expect(data).to have_key('id')
      expect(data).to have_key('type')
      expect(data['type']).to eq('munchie')
      expect(data).to have_key('attributes')

      attributes = data['attributes']
      expect(attributes).to have_key('destination_city')
      expect(attributes).to have_key('forecast')
      expect(attributes).to have_key('restaurant')
    end
  end
end