require 'rails_helper'

describe YelpFacade do
  before do
    @api_key = 'your_test_api_key'
    @faraday_connection = instance_double(Faraday::Connection)
    allow(Faraday).to receive(:new).and_return(@faraday_connection)
  end

  describe '#get_event' do
    it 'returns event data' do
      response_body = { 'name' => 'Local Event' }.to_json
      allow(@faraday_connection).to receive(:get).and_return(
        double('response', success?: true, body: response_body)
      )

      facade = YelpFacade.new(@api_key)
      event_data = facade.get_event('local-event')

      expect(event_data['name']).to eq('Local Event')
    end

    it 'handles API request failure' do
      allow(@faraday_connection).to receive(:get).and_return(
        double('response', success?: false)
      )

      facade = YelpFacade.new(@api_key)
      event_data = facade.get_event('local-event')

      expect(event_data).to be_nil
    end
  end
end