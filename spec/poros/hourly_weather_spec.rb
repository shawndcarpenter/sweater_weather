require "rails_helper"

RSpec.describe HourlyWeather do
  describe "daily Weather Objects", :vcr do
    before :each do
      @dhourly_weathers = WeatherFacade.new(39.10713, -84.50413).forecast.hourly_weather
    end

    it "exists" do
      @dhourly_weathers.each do |hourly_weather|
        expect(hourly_weather).to be_a HourlyWeather
      end
    end

    it "responds to hourly_weather methods" do
      @dhourly_weathers.each do |hourly_weather|
        expect(hourly_weather).to respond_to(:conditions)
        expect(hourly_weather).to respond_to(:icon)
        expect(hourly_weather).to respond_to(:time)
        expect(hourly_weather).to respond_to(:temperature)
      end
    end
  end
end