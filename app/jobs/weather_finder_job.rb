class WeatherFinderJob < ApplicationJob
  queue_as :default

  def perform(weather_json, arrival_time)
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
