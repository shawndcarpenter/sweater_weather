class RoadTripFacade
  def initialize(origin, destination, destination_geocode)
    @origin = origin
    @destination = destination
    @destination_geocode = destination_geocode
  end

  def road_trip
    routing_json = get_location_json(@origin, @destination) # find the route from origin to destination
    travel_time = get_travel_time(routing_json) # get travel time or "impossible" if no route found
    weather_json = get_weather_json(@destination_geocode) # find the weather for the destination
    arrival_time = get_arrival_time(travel_time, 
                                    routing_json, 
                                    weather_json) # get arrival time in epoch
    weather = get_weather(routing_json, 
                          @destination_geocode, 
                          weather_json, 
                          arrival_time) # create a weather object, or {} if routing impossible

    @road_trip = RoadTrip.new(@origin, @destination, travel_time, weather)
  end

  private
  def get_location_json(origin, destination)
    location_service = LocationService.new
    location_service.find_route(@origin, @destination)
  end

  def get_travel_time(routing_json)
    if routing_json[:route].include?(:routeError)
      "impossible"
    else
      routing_json[:route][:formattedTime]
    end
  end

  def get_weather_json(destination_geocode)
    weather_service = WeatherService.new
    weather_service.find_weather(destination_geocode.latitude, destination_geocode.longitude)
  end

  def get_arrival_time(travel_time, routing_json, weather_json)
    if travel_time != "impossible"
      time_elapsed = routing_json[:route][:time]
      epoch = Time.current.to_i
      time_elapsed + epoch
    end
  end

  def get_weather(routing_json, destination_geocode, weather_json, arrival_time)
    if routing_json[:route].include?(:routeError)
      {}
    else
      create_weather_at_eta(weather_json, arrival_time)
    end
  end
  
  def create_weather_at_eta(weather_json, arrival_time)
    weather_json[:forecast][:forecastday].each do |daily_weather|
      daily_weather[:hour].map do |hourly_weather|
        if (hourly_weather[:time_epoch]..hourly_weather[:time_epoch] + 3599).include?(arrival_time)
          @weather = WeatherAtEta.new(arrival_time, hourly_weather, weather_json)
        end
      end
    end
    @weather
  end
end