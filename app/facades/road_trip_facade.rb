class RoadTripFacade
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def road_trip
    service = LocationService.new
    routing_json = service.find_route(@origin, @destination)
  
    @road_trip = RoadTrip.new(routing_json, origin, destination)
  end
end