class WeatherAtEta
  attr_reader :datetime, :temperature, :condition

  def initialize(arrival_time, hourly_weather)
    @datetime = readable_datetime(arrival_time)
    @temperature = hourly_weather[:temp_f]
    @condition = hourly_weather[:condition][:text]
  end

  def readable_datetime(arrival_time)
    time_array = arrival_time.to_fs.split(" ")
    time_array[0] + " " + time_array[1]
  end
end