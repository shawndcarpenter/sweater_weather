require "rails_helper"

RSpec.describe RoadTrip do
  describe "Road Trip Objects", :vcr do
    before :each do
      destination_geocode = GeolocationFacade.new("Cincinatti,OH").geocode 
      @weather_at_eta = RoadTripFacade.new("Chicago,IL", "Cincinatti,OH", destination_geocode).road_trip.weather_at_eta
    end

    it "exists" do
      expect(@weather_at_eta).to be_a WeatherAtEta
    end

    it "responds to weather_at_eta methods" do
      expect(@weather_at_eta).to respond_to(:datetime)
      expect(@weather_at_eta).to respond_to(:temperature)
      expect(@weather_at_eta).to respond_to(:condition)
    end
  end
end