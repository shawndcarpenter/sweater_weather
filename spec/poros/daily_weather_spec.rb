require "rails_helper"

RSpec.describe DailyWeather do
  describe "daily Weather Objects", :vcr do
    before :each do
      @daily_weathers = WeatherFacade.new(39.10713, -84.50413).forecast.daily_weather
    end

    it "exists" do
      @daily_weathers.each do |daily_weather|
        expect(daily_weather).to be_a DailyWeather
      end
    end

    it "responds to daily_weather methods" do
      @daily_weathers.each do |daily_weather|
        expect(daily_weather).to respond_to(:date)
        expect(daily_weather).to respond_to(:condition)
        expect(daily_weather).to respond_to(:sunrise)
        expect(daily_weather).to respond_to(:sunset)
        expect(daily_weather).to respond_to(:max_temp)
        expect(daily_weather).to respond_to(:min_temp)
        expect(daily_weather).to respond_to(:icon)
        expect(daily_weather).to respond_to(:visibility)
      end
    end
  end
end