require 'rails_helper'

RSpec.describe "Road Trips", type: :request do
  describe "happy paths" do
    it "will return the weather upon arrival", :vcr do
      user = User.create!(email: "whatever@example.com",
                          password: "password",
                          password_confirmation: "password",
                          api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
      # binding.pry                    
      post "/api/v0/road_trip", params: {
        "origin": "Cincinatti,OH",
        "destination": "Chicago,IL",
        "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
      }, as: :json

      expect(response).to be_successful
      
      expect(response.status).to eq(200)
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:data)
      expect(result[:data]).to be_a Hash

      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to eq(nil)

      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to eq("road_trip")

      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a Hash

      expect(result[:data][:attributes]).to have_key(:start_city)
      expect(result[:data][:attributes][:start_city]).to be_a String

      expect(result[:data][:attributes]).to have_key(:end_city)
      expect(result[:data][:attributes][:end_city]).to be_a String

      expect(result[:data][:attributes]).to have_key(:travel_time)
      expect(result[:data][:attributes][:travel_time]).to be_a String

      expect(result[:data][:attributes]).to have_key(:weather_at_eta)
      expect(result[:data][:attributes][:weather_at_eta]).to be_a Hash

      expect(result[:data][:attributes][:weather_at_eta]).to have_key(:datetime)
      expect(result[:data][:attributes][:weather_at_eta][:datetime]).to be_a String

      expect(result[:data][:attributes][:weather_at_eta]).to have_key(:temperature)
      expect(result[:data][:attributes][:weather_at_eta][:temperature]).to be_a Float

      expect(result[:data][:attributes][:weather_at_eta]).to have_key(:condition)
      expect(result[:data][:attributes][:weather_at_eta][:condition]).to be_a String
    end
  end

  describe "sad paths" do
    it "will return unauthorized if no users found with api_key" do
      user = User.create!(email: "whatever@example.com",
      password: "password",
      password_confirmation: "password",
      api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
                
      post "/api/v0/road_trip", params: {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": "not_api_key"
      }, as: :json
    end

  end
end