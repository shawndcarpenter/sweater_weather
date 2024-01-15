class Business
  attr_reader :name, :address, :rating, :reviews
  def initialize(data)
    @name = data[:name]
    @address = data[:location][:display_address].first
    @rating = data[:rating]
    @reviews = data[:review_count]
  end
end
