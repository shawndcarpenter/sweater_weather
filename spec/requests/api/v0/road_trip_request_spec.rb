require 'rails_helper'

RSpec.describe "Road Trips", type: :request do
  describe "happy paths" do
    it "will return the weather upon arrival", :vcr do
      user = User.create!(email: "whatever@example.com",
                          password: "password",
                          password_confirmation: "password",
                          api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
                   
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
      expect(result[:data][:attributes][:start_city]).to eq("Cincinatti,OH")

      expect(result[:data][:attributes]).to have_key(:end_city)
      expect(result[:data][:attributes][:end_city]).to be_a String
      expect(result[:data][:attributes][:end_city]).to eq("Chicago,IL")

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
    it "will return unauthorized if no users found with api_key", :vcr do
      user = User.create!(email: "whatever@example.com",
      password: "password",
      password_confirmation: "password",
      api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
                
      post "/api/v0/road_trip", params: {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL",
      "api_key": "not_api_key"
      }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
  
      data = JSON.parse(response.body, symbolize_names: true)
  
      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Unauthorized: please provide a valid api_key")
    end

    it "will return unauthorized if no api_key is provided", :vcr do
      user = User.create!(email: "whatever@example.com",
      password: "password",
      password_confirmation: "password",
      api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
                
      post "/api/v0/road_trip", params: {
      "origin": "Cincinatti,OH",
      "destination": "Chicago,IL"
      }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(401)
  
      data = JSON.parse(response.body, symbolize_names: true)
  
      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Unauthorized: please provide a valid api_key")
    end

    it "Must have origin", :vcr do
      user = User.create!(email: "whatever@example.com",
      password: "password",
      password_confirmation: "password",
      api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
                
      post "/api/v0/road_trip", params: {
      "destination": "Chicago,IL",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
      }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
  
      data = JSON.parse(response.body, symbolize_names: true)
  
      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: origin can't be blank")
    end

    it "Must have all fields", :vcr do
      user = User.create!(email: "whatever@example.com",
      password: "password",
      password_confirmation: "password",
      api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
                
      post "/api/v0/road_trip", params: {
      }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
  
      data = JSON.parse(response.body, symbolize_names: true)
  
      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: origin can't be blank, destination can't be blank, api_key can't be blank")
    end

    it "must have real locations", :vcr do
      user = User.create!(email: "whatever@example.com",
      password: "password",
      password_confirmation: "password",
      api_key: "t1h2i3s4_i5s6_l7e8g9i10t11")
                
      post "/api/v0/road_trip", params: {
      "origin": "wfowenoeneroifnionf1233",
      "destination": "Chicago,IL",
      "api_key": "t1h2i3s4_i5s6_l7e8g9i10t11"
      }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(422)
  
      data = JSON.parse(response.body, symbolize_names: true)
  
      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: origin and destination must be real places")
    end
  end
end