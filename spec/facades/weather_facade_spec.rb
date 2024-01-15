require 'rails_helper'

describe WeatherFacade do
  context "weather", :vcr do
    it "exists" do
      facade = WeatherFacade.new(39.10713, -84.50413)

      expect(facade).to be_a WeatherFacade
    end

    it "can find weather based on latitude and longitude" do
      forecast = WeatherFacade.new(39.10713, -84.50413).forecast

      expect(forecast).to be_a Forecast
      expect(forecast.current_weather).to be_a CurrentWeather
      expect(forecast.current_weather.condition).to be_a String
      expect(forecast.current_weather.feels_like).to be_a Float
      expect(forecast.current_weather.humidity).to be_a Integer
      expect(forecast.current_weather.icon).to be_a String
      expect(forecast.current_weather.last_updated).to be_a String
      expect(forecast.current_weather.temperature).to be_a Float
      expect(forecast.current_weather.uvi).to be_a Float
      expect(forecast.current_weather.visibility).to be_a Float


      expect(forecast.daily_weather).to be_a Array
      forecast.daily_weather.each do |daily|
        expect(daily).to be_a DailyWeather
        expect(daily.date).to be_a String
        expect(daily.icon).to be_a String
        expect(daily.max_temp).to be_a Float
        expect(daily.min_temp).to be_a Float
        expect(daily.sunrise).to be_a String
        expect(daily.sunset).to be_a String
        expect(daily.condition).to be_a String
        expect(daily.visibility).to be_a Float
      end
    end
  end
end