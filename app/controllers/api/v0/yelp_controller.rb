class YelpController < ApplicationController
  def get_yelp_data
    api_key = ENV['YELP_API_KEY']
    facade = YelpFacade.new(api_key)
    @data = facade.get_event('awesome-event')

    if @data.nil?
      @error_message = 'Failed to retrieve data from Yelp API.'
    end
  end
end