class Business
  attr_reader :destination_city, :name, :address, :rating, :reviews
  def initialize(data)
    @destination_city = "#{data[:location][:city]}, #{data[:location][:state]}"
    @name = data[:name]
    @address = data[:location][:display_address].first
    @rating = data[:rating]
    @reviews = data[:review_count]
  end
end
