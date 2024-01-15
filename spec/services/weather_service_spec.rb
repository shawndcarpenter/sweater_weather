require 'rails_helper'

describe WeatherService do
  context "finds weather", :vcr do
    it "connects" do
      service = WeatherService.new 
      expect(service.conn).to be_instance_of Faraday::Connection
    end

    it "gets_weather" do
      weather = WeatherService.new.find_weather(39.10713, -84.50413)
      expect(weather).to be_a Hash
  
      expect(weather).to have_key(:location)
      expect(weather[:location]).to be_a Hash

      expect(weather[:location]).to have_key(:name)
      expect(weather[:location][:name]).to be_a String
      
      expect(weather[:location]).to have_key(:region)
      expect(weather[:location][:region]).to be_a String

      expect(weather).to have_key(:current)
      expect(weather[:current]).to be_a Hash
      
      expect(weather[:current]).to have_key(:temp_c)
      expect(weather[:current][:temp_c]).to be_a Float

      expect(weather).to have_key(:forecast)
      expect(weather[:forecast]).to be_a Hash
      
      expect(weather[:forecast]).to have_key(:forecastday)
      expect(weather[:forecast][:forecastday]).to be_a Array
    end
  end
end