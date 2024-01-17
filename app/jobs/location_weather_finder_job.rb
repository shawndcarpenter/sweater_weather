class LocationWeatherFinderJob < ApplicationJob
  queue_as :default

  def perform(destination_geocode)
    weather_service = WeatherService.new
    
    weather_service.find_weather(destination_geocode.latitude, destination_geocode.longitude)
  end
end
