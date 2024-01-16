class WeatherAtEta
  attr_reader :datetime, :temperature, :condition

  def initialize(arrival_time, hourly_weather, weather_json)
    @datetime = readable_datetime(arrival_time, weather_json)
    @temperature = hourly_weather[:temp_f]
    @condition = hourly_weather[:condition][:text]
  end

  
  def readable_datetime(arrival_time, weather_json)
    if arrival_time == "n/a"
      "n/a"
    else
      Time.zone = weather_json[:location][:tz_id] # find local time zone
      time_array = Time.zone.at(arrival_time).to_fs.split(" ") # find time at time zone, turn into string
      time_array[0] + " " + time_array[1] # remove unnecessary info from string
    end
  end
end