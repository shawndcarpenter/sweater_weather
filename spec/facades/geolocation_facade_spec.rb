require 'rails_helper'

describe GeolocationFacade do
  context "Geolocation", :vcr do
    it "exists" do
      facade = GeolocationFacade.new("pueblo,co")

      expect(facade).to be_a GeolocationFacade
    end

    it "can find geolocation based on city and state" do
      geocode = GeolocationFacade.new("pueblo,co").geocode

      expect(geocode).to be_a Geocode
      expect(geocode.latitude).to be_a Float
      expect(geocode.longitude).to be_a Float
    end
  end
end