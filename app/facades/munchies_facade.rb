class MunchiesFacade
  def initialize(destination, food, geo)
    @destination = destination
    @food = food
    @geo = geo
  end

  def munchie
    business_service = MunchiesService.new
    business_json = business_service.get_munchies(@destination, @food)
    business = business_json[:businesses].first
    weather_service = WeatherService.new
    weather_json = weather_service.find_weather(@geo.latitude, @geo.longitude)
    @destination_city = "#{business[:location][:city]}, #{business[:location][:state]}"
    @forecast = ShortForecast.new(weather_json[:current])
    @business = Business.new(business)
    @munchie = Munchie.new(@destination_city, @business, @forecast)
  end
end