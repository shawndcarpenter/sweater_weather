class WeatherFacade
  def initialize(latitude, longitude)
    @latitude = latitude
    @longitude = longitude
  end

  def forecast
    service = WeatherService.new
    json = service.find_weather(@latitude, @longitude)
    Forecast.new(json)
  end
end