class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta, :id

  def initialize(origin, destination, travel_time, weather)
    @start_city = origin
    @end_city = destination
    @travel_time = travel_time
    @weather_at_eta = weather
    @id = nil
  end
end