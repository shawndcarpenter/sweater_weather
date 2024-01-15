require "rails_helper"

RSpec.describe MunchiesFacade do  
  it "gets a business, forecast and destination info", :vcr do
    destination = "pueblo,co"
    geo = GeolocationFacade.new(destination).geocode
    food = "italian"
    munchie = MunchiesFacade.new(destination, food, geo).munchie

    expect(munchie.destination_city).to be_a String
    expect(munchie.forecast).to be_a ShortForecast
    expect(munchie.id).to eq(nil)
    expect(munchie.restaurant).to be_a Business
  end
end