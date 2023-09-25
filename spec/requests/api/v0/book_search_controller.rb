require 'rails_helper'

RSpec.describe BookSearchController, type: :controller do
  it 'returns book search results for a location' do
    allow_any_instance_of(WeatherFacade).to receive(:get_forecast).and_return(
      current_weather: { temperature: 75 },
      daily_weather: [],
      hourly_weather: []
    )

    allow_any_instance_of(LibraryService).to receive(:search_location).and_return(
      numFound: 5,
      docs: [
        { title: 'Book 1', author: 'Author 1' },
        { title: 'Book 2', author: 'Author 2' }
      ]
    )

    get :index, params: { location: 'vermont', quantity: 5 }
    json_response = JSON.parse(response.body)

    expect(json_response['location']).to eq('vermont')
    expect(json_response['current_weather']['temperature']).to eq(75)
    expect(json_response['total_results']).to eq(5)
    expect(json_response['books'].size).to eq(5)
  end

  it 'returns an error for invalid quantity' do
    get :index, params: { location: 'vermont', quantity: -1 }
    json_response = JSON.parse(response.body)

    expect(response).to have_http_status(:bad_request)
    expect(json_response['error']).to eq('Quantity must be a positive integer greater than 0')
  end
end