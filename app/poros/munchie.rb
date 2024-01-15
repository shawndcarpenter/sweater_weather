class Munchie
  attr_reader :destination_city, :forecast, :restaurant, :id
  
  def initialize(destination_data, business_data, weather_data)
    @id = nil
    @destination_city = destination_data
    @forecast = weather_data
    @restaurant = business_data
  end
end
