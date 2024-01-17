class RoadTrip < WeatherAtEta
  attr_reader :start_city, :end_city, :travel_time, :weather_at_eta, :id

  def initialize(origin, destination, routing_json, weather_json, destination_geocode)
    @start_city = origin
    @end_city = destination
    @travel_time = get_travel_time(routing_json)
    @arrival_time = get_arrival_time(@travel_time, routing_json, weather_json)
    @weather_at_eta = get_weather(routing_json, destination_geocode, weather_json, @arrival_time)
    @id = nil
  end

  private

  def get_travel_time(routing_json) # get travel time or "impossible" if no route found
    if routing_json[:route].include?(:routeError)
      "impossible"
    else
      routing_json[:route][:formattedTime]
    end
  end

  def get_arrival_time(travel_time, routing_json, weather_json) # get arrival time in epoch
    if travel_time != "impossible"
      time_elapsed = routing_json[:route][:time]
      epoch = Time.current.to_i
      
      time_elapsed + epoch
    end
  end

  def get_weather(routing_json, destination_geocode, weather_json, arrival_time)  # create a weather object, or {} if routing impossible
    if routing_json[:route].include?(:routeError)
      {}
    else
      create_weather_at_eta_object(weather_json, arrival_time)
    end
  end

  def create_weather_at_eta_object(weather_json, arrival_time)
    WeatherFinderJob.perform_now(weather_json, arrival_time)
  end
end