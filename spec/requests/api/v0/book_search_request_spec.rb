require 'rails_helper'

RSpec.describe Api::V0::BookSearchController, type: :controller do
  describe 'GET #index', vcr: { cassette_name: 'weather' } do
    it 'search results for a book and weather data' do
      get :index, params: { location: 'Vermont', quantity: 2 }
      json_response = JSON.parse(response.body)

      # Debugging
      puts JSON.pretty_generate(json_response)

      # Debugging
      puts "Destination: #{json_response['data']['attributes']['destination']}"

      expect(json_response['data']['attributes']['destination']).to eq('Vermont')
      expect(json_response['data']['attributes']['forecast']['summary']).not_to be_nil
      expect(json_response['data']['attributes']['forecast']['temperature']).not_to be_nil
      expect(json_response['data']['attributes']['total_books_found']).not_to be_nil
      expect(json_response['data']['attributes']['books']).not_to be_nil
      expect(json_response['data']['attributes']['books'].size).to eq(2)
      expect(json_response['data']['attributes']['books'][0]['title']).not_to be_nil
      expect(json_response['data']['attributes']['books'][1]['title']).not_to be_nil

    end

    it 'returns an error for invalid quantity' do
      get :index, params: { location: 'Vermont', quantity: -1 }
      json_response = JSON.parse(response.body)

      expect(response).to have_http_status(:bad_request)
      expect(json_response['error']).to eq('Quantity must be a positive integer greater than 0')
    end
  end
end