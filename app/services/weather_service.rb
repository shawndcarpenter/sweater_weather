class WeatherService
  def conn
    Faraday.new(url: "https://api.weatherapi.com/v1/") do |faraday|
      faraday.headers["key"] = Rails.application.credentials.weather_api[:key]
    end
  end

  def find_weather(latitude, longitude)
    response = conn.get("forecast.json?q=#{latitude},#{longitude}&days=5")
    JSON.parse(response.body, symbolize_names: true)
  end
end