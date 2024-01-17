class RoadTripFacade
  def initialize(origin, destination, destination_geocode)
    @origin = origin
    @destination = destination
    @destination_geocode = destination_geocode
  end

  def road_trip
    routing_json = get_location_json(@origin, @destination) # find the route from origin to destination
    weather_json = get_weather_json(@destination_geocode) # find the weather for the destination

    @road_trip = RoadTrip.new(@origin, @destination, routing_json, weather_json, @destination_geocode)
  end

  private

  def get_location_json(origin, destination)
    location_service = LocationService.new

    location_service.find_route(@origin, @destination)
  end

  def get_weather_json(destination_geocode)
    weather_service = WeatherService.new
    
    weather_service.find_weather(destination_geocode.latitude, destination_geocode.longitude)
  end
end