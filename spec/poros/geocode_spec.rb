require 'rails_helper'

RSpec.describe Geocode do
  describe "geocode Objects", :vcr do
    before :each do
      @geocode = GeolocationFacade.new("pueblo,co").geocode
    end

    it "exists" do
      expect(@geocode).to be_a Geocode
    end

    it "responds to geocode methods" do
      expect(@geocode).to respond_to(:latitude)
      expect(@geocode).to respond_to(:longitude)
    end
  end
end