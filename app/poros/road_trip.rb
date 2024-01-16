class RoadTrip
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta, :id

  def initialize(origin, destination, travel_time, weather)
    @start_city = origin
    @end_city = destination
    @travel_time = travel_time
    @weather_at_eta = weather
    @id = nil
  end

  # find the travel time
  # find the localtime_epoch for forecast
  # add travel time to localtime to get datetime
  # find daily_weather with time_epoch that matches

  def time_zone

  end
end