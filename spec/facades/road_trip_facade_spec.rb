require 'rails_helper'

RSpec.describe RoadTripFacade do
  context "RoadTrip object", :vcr do
    it "exists" do
      destination_geocode = GeolocationFacade.new("Cincinatti,OH").geocode 
      road_trip_facade = RoadTripFacade.new("Chicago,IL", "Cincinatti,OH", destination_geocode)

      expect(road_trip_facade).to be_a RoadTripFacade
    end

    it "can create road trip objects", :vcr do
      destination_geocode = GeolocationFacade.new("Cincinatti,OH").geocode 
      road_trip = RoadTripFacade.new("Chicago,IL", "Cincinatti,OH", destination_geocode).road_trip

      expect(road_trip).to respond_to(:start_city)
      expect(road_trip.start_city).to eq("Chicago,IL")

      expect(road_trip).to respond_to(:end_city)
      expect(road_trip.end_city).to eq("Cincinatti,OH")

      expect(road_trip).to respond_to(:travel_time)
      
      expect(road_trip).to respond_to(:weather_at_eta)
      expect(road_trip.weather_at_eta).to be_a WeatherAtEta

      expect(road_trip).to respond_to(:id)
    end
  end
end