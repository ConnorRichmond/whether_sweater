class BookSearchSerializer
  include JSONAPI::Serializer

  attributes :location, :quantity, :books

  def books
    object['books']
  end
end