class MunchiesFacade
  def initialize(destination, food, geo)
    @destination = destination
    @food = food
    @geo = geo
  end

  def munchie
    destination_city = readable_destination(@destination)
    business = get_business(@destination, @food)
    forecast = get_weather(@geo)

    Munchie.new(destination_city, business, forecast)
  end

  private
  def readable_destination(destination)
    destination_array = destination.split(',')
    destination_array[0].capitalize!
    destination_array[1].upcase!
    destination_array.join(', ')
  end

  def get_business(destination, food)
    business_service = BusinessService.new
    business_json = business_service.get_businesses(destination, food)
    business = business_json[:businesses].first

    Business.new(business)
  end

  def get_weather(geo)
    weather_service = WeatherService.new
    weather_json = weather_service.find_weather(geo.latitude, geo.longitude)

    ShortForecast.new(weather_json[:current])
  end
end