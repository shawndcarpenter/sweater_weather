class Business
  attr_reader :last_updated, :destination_city, :name, :address, :rating, :reviews
  def initialize(data)
    @last_updated = data[:last_updated]
    @destination_city = "#{data[:location][:city]}, #{data[:location][:state]}"
    @name = data[:name]
    @address = data[:location][:]
end