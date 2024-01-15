class Munchie
  attr_reader :destination_city, :forecast, :restaurant
  def initialize(business_data, weather_data)
    @destination_city = 
    @forecast = ShortForecast.new(weather_data)
    @restaurant = Business.new(business_data)
  end
end
