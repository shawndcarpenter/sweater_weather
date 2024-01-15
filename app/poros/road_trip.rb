class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta

  def initialize(routing_json, origin, destination)
    @start_city = origin
    @end_city = destination
    @travel_time = routing_json[:route][:formattedTime]
    @weather_at_eta = WeatherAtEta.new(routing_json[:route][:realTime])
  end

  # find the travel time
  # find the localtime_epoch for forecast
  # add travel time to localtime to get datetime
  # find daily_weather with time_epoch that matches

  def time_zone

  end
end