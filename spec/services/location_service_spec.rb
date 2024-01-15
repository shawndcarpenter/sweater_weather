require 'rails_helper'

describe LocationService do
  context "finds location", :vcr do
    it "connects" do
      service = LocationService.new 
      expect(service.conn).to be_instance_of Faraday::Connection
    end

    it "gets location" do
      location = LocationService.new.find_lat_and_lon("pueblo,co")
      expect(location).to be_a Hash

      expect(location).to have_key(:info)
      expect(location[:info]).to be_a Hash

      expect(location).to have_key(:results)
      expect(location[:results]).to be_a Array

      expect(location[:results].first).to have_key(:locations)
      expect(location[:results].first[:locations]).to be_a Array

      expect(location[:results].first[:locations].first).to have_key(:street)
      expect(location[:results].first[:locations].first[:street]).to be_a String

      expect(location[:results].first[:locations].first).to have_key(:latLng)
      expect(location[:results].first[:locations].first[:latLng]).to be_a Hash
    end
  end
end