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

    it "gets route" do
      location = LocationService.new.find_route("Pueblo,CO", "Denver,CO")
      expect(location).to be_a Hash

      expect(location).to have_key(:info)
      expect(location[:info]).to be_a Hash

      expect(location).to have_key(:route)
      expect(location[:route]).to be_a Hash

      expect(location[:route]).to have_key(:sessionId)
      expect(location[:route][:sessionId]).to be_a String

      expect(location[:route]).to have_key(:time)
      expect(location[:route][:time]).to be_a Integer

      expect(location[:route]).to have_key(:distance)
      expect(location[:route][:distance]).to be_a Float

      expect(location[:route]).to have_key(:formattedTime)
      expect(location[:route][:formattedTime]).to be_a String
    end
  end
end