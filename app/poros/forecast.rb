class Forecast
  attr_reader

  def initialize(data)
    @current_weather = CurrentWeather.new(data[:current])
    @daily_weather = (data[:forecast][:forecastday]).map do |day|
      DailyWeather.new(day)
    end
    
    @hourly_weather = (data[:forecast][:forecastday].first[:hour]).map do |hour|
      HourlyWeather.new(hour)
    end
  end
end