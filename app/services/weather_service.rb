require "connectable.rb"

class WeatherService
  include Connectable

  def conn
    Faraday.new(url: "https://api.weatherapi.com/v1/") do |faraday|
      faraday.headers["key"] = Rails.application.credentials.weather_api[:key]
    end
  end

  def find_weather(latitude, longitude)
    get_url("forecast.json?q=#{latitude},#{longitude}&days=5")
  end
end