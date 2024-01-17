require "rails_helper"

RSpec.describe RoadTrip do
  describe "Road Trip Objects", :vcr do
    before :each do
      destination_geocode = GeolocationFacade.new("Cincinatti,OH").geocode 
      @road_trip = RoadTripFacade.new("Chicago,IL", "Cincinatti,OH", destination_geocode).road_trip
    end

    it "exists" do
      expect(@road_trip).to be_a RoadTrip
    end

    it "responds to road_trip methods" do
      expect(@road_trip).to respond_to(:start_city)
      expect(@road_trip.start_city).to eq("Chicago,IL")

      expect(@road_trip).to respond_to(:end_city)
      expect(@road_trip.end_city).to eq("Cincinatti,OH")

      expect(@road_trip).to respond_to(:travel_time)
      
      expect(@road_trip).to respond_to(:weather_at_eta)

      expect(@road_trip).to respond_to(:id)
    end
  end
end