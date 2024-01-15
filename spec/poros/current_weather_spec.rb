require "rails_helper"

RSpec.describe CurrentWeather do
  describe "Current Weather Objects", :vcr do
    before :each do
      @current_weather = WeatherFacade.new(39.10713, -84.50413).forecast.current_weather
    end

    it "exists" do
      expect(@current_weather).to be_a CurrentWeather
    end

    it "responds to current_weather methods" do
      expect(@current_weather).to respond_to(:condition)
      expect(@current_weather).to respond_to(:feels_like)
      expect(@current_weather).to respond_to(:humidity)
      expect(@current_weather).to respond_to(:icon)
      expect(@current_weather).to respond_to(:last_updated)
      expect(@current_weather).to respond_to(:temperature)
      expect(@current_weather).to respond_to(:uvi)
      expect(@current_weather).to respond_to(:visibility)
    end
  end
end