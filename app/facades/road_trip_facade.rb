class RoadTripFacade
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def road_trip
    destination_geocode = GeolocationFacade.new(@destination).geocode  # find the geolocation of destination
    routing_json = get_location_json(@origin, @destination) # find the route from origin to destination
    travel_time = get_travel_time(routing_json) # get travel time or "impossible" if no route found
    weather_json = get_weather_json(destination_geocode) # find the weather for the destination
    arrival_time = get_arrival_time(travel_time, 
                                    routing_json, 
                                    weather_json) # get arrival time in epoch

    readable_arrival_time = get_readable_arrival_time(arrival_time, weather_json) # get readable arrival time
    weather = get_weather(routing_json, 
                          destination_geocode, 
                          weather_json, 
                          arrival_time, 
                          readable_arrival_time) # create a weather object, or {} if routing impossible
                          
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

  def get_weather(routing_json, destination_geocode, weather_json, arrival_time, readable_arrival_time)
    if routing_json[:route].include?(:routeError)
      {}
    else
      create_weather_at_eta(weather_json, arrival_time, readable_arrival_time)
    end
  end
  
  def create_weather_at_eta(weather_json, arrival_time, readable_arrival_time)
    weather_json[:forecast][:forecastday].each do |daily_weather|
      daily_weather[:hour].map do |hourly_weather|
        if (hourly_weather[:time_epoch]..hourly_weather[:time_epoch] + 3599).include?(arrival_time)
          @weather = WeatherAtEta.new(readable_arrival_time, hourly_weather)
        end
      end
    end
    @weather
  end

  def get_weather_json(destination_geocode)
    weather_service = WeatherService.new
    weather_service.find_weather(destination_geocode.latitude, destination_geocode.longitude)
  end

  def get_arrival_time(travel_time, routing_json, weather_json)
    if travel_time == "impossible"
      "n/a"
    else
      time_elapsed = routing_json[:route][:realTime]
      epoch = weather_json[:location][:localtime_epoch]
      time_elapsed + epoch
    end
  end

  def get_readable_arrival_time(arrival_time, weather_json)
    if arrival_time == "n/a"
      "n/a"
    else
      time_in_destination(arrival_time, weather_json)
    end
  end

  def time_in_destination(arrival_time, weather_json)
    Time.zone = weather_json[:location][:tz_id]
    Time.zone.at(arrival_time)
  end
end