require 'rails_helper'

RSpec.describe Api::V0::BookSearchController, type: :controller do
  it 'returns book search results for a location with stubbed weather data' do

    allow_any_instance_of(WeatherFacade).to receive(:get_forecast).with('Vermont').and_return(
      current_weather: {
        condition: 'Sunny',
        temperature: 75
      },
      daily_weather: [],
      hourly_weather: []
    )

    allow_any_instance_of(LibraryService).to receive(:search_location).and_return(
      numFound: 5,
      docs: [
        { isbn: ['0762507845', '9780762507849'], title: 'Vermont Book 1' },
        { isbn: ['9780883183663', '0883183668'], title: 'Vermont Book 2' }
      ]
    )

    get :index, params: { location: 'Vermont', quantity: 2 }
    json_response = JSON.parse(response.body)

    expect(json_response['data']['attributes']['destination']).to eq('Vermont')
    expect(json_response['data']['attributes']['forecast']['summary']).to eq('Sunny')
    expect(json_response['data']['attributes']['forecast']['temperature']).to eq('75 F')
    expect(json_response['data']['attributes']['total_books_found']).to eq(5)
    expect(json_response['data']['attributes']['books'].size).to eq(2)
    expect(json_response['data']['attributes']['books'][0]['title']).to eq('Vermont Book 1')
    expect(json_response['data']['attributes']['books'][1]['title']).to eq('Vermont Book 2')
  end

  it 'returns an error for invalid quantity' do
    get :index, params: { location: 'Vermont', quantity: -1 }
    json_response = JSON.parse(response.body)

    expect(response).to have_http_status(:bad_request)
    expect(json_response['error']).to eq('Quantity must be a positive integer greater than 0')
  end
end