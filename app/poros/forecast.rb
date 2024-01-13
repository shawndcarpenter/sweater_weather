class Forecast
  attr_reader :current_weather, :daily_weather, :hourly_weather, :id

  def initialize(data)
    @id = nil
    @current_weather = CurrentWeather.new(data[:current])
    @daily_weather = get_daily_weather(data)
    @hourly_weather = get_hourly_weather(data)
  end
  
  def get_hourly_weather(data)
    (data[:forecast][:forecastday].first[:hour]).map do |hour|
      HourlyWeather.new(hour)
    end 
  end
  
  def get_daily_weather(data)
    (data[:forecast][:forecastday]).map do |day|
      DailyWeather.new(day)
    end
  end
end