require "rails_helper"

RSpec.describe Forecast do
  describe "Forecast Objects", :vcr do
    before :each do
      @forecast = WeatherFacade.new(39.10713, -84.50413).forecast
    end

    it "exists" do
      expect(@forecast).to be_a Forecast
    end

    it "responds to forecast methods" do
      expect(@forecast).to respond_to(:daily_weather)
      expect(@forecast).to respond_to(:current_weather)
      expect(@forecast).to respond_to(:hourly_weather)
      expect(@forecast).to respond_to(:id)
    end
  end
end