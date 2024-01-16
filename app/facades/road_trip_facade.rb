class RoadTripFacade
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def road_trip
    # find the geolocation of destination
    destination_geocode = GeolocationFacade.new(@destination).geocode
    
    # find the route from origin to destination
    location_service = LocationService.new
    routing_json = location_service.find_route(@origin, @destination)

    if routing_json[:route].include?(:routeError)
      travel_time = "impossible"
      @weather = {}
    else
      travel_time = routing_json[:route][:formattedTime]
      
      # find the weather for the destination
      weather_service = WeatherService.new
      weather_json = weather_service.find_weather(destination_geocode.latitude, destination_geocode.longitude)
      
      # find the arrival time epoch
      time_elapsed = routing_json[:route][:realTime]
      epoch = weather_json[:location][:localtime_epoch]
      Time.zone = weather_json[:location][:tz_id]
      arrival_time = time_elapsed + epoch

      readable_arrival_time = Time.zone.at(arrival_time)
      # look through response and find a matching epoch
      weather_json[:forecast][:forecastday].each do |daily_weather|
        daily_weather[:hour].map do |hourly_weather|
          if (hourly_weather[:time_epoch]..hourly_weather[:time_epoch] + 3599).include?(arrival_time)
            @weather = WeatherAtEta.new(readable_arrival_time, hourly_weather)
          end
        end
      end
    end

    @road_trip = RoadTrip.new(@origin, @destination, travel_time, @weather)
  end
end