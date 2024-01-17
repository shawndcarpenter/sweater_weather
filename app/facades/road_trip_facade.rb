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
    RouteFinderJob.perform_now(origin, destination)
  end

  def get_weather_json(destination_geocode)
    LocationWeatherFinderJob.perform_now(destination_geocode)
  end
end