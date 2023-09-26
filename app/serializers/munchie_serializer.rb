class MunchieSerializer
  def initialize(data)
    @data = data
  end

  def to_json
    {
      data: {
        id: nil,
        type: "munchie",
        attributes: {
          destination_city: @data[:destination_city],
          forecast: {
            summary: @data[:forecast][:summary],
            temperature: @data[:forecast][:temperature]
          },
          restaurant: {
            name: @data[:restaurant][:name],
            address: @data[:restaurant][:address],
            rating: @data[:restaurant][:rating],
            reviews: @data[:restaurant][:reviews]
          }
        }
      }
    }
  end
end