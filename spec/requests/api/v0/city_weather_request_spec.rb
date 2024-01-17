require 'rails_helper'

RSpec.describe "Find weather for a city", type: :request do
  describe "happy paths" do
    it "will return the weather for a city", :vcr do
      
      get "/api/v0/forecast?location=cincinatti,oh"

      expect(response).to be_successful
      
      expect(response.status).to eq(200)
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result).to have_key(:data)
      expect(result[:data]).to be_a Hash

      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to eq(nil)

      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to be_a String
      expect(result[:data][:type]).to eq("forecast")

      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]). to be_a Hash

      expect(result[:data][:attributes]).to have_key(:current_weather)
      expect(result[:data][:attributes][:current_weather]). to be_a Hash

      expect(result[:data][:attributes][:current_weather]).to have_key(:last_updated)
      expect(result[:data][:attributes][:current_weather][:last_updated]). to be_a String

      expect(result[:data][:attributes][:current_weather]).to have_key(:temperature)
      expect(result[:data][:attributes][:current_weather][:temperature]). to be_a Float

      expect(result[:data][:attributes][:current_weather]).to have_key(:feels_like)
      expect(result[:data][:attributes][:current_weather][:feels_like]). to be_a Float

      expect(result[:data][:attributes][:current_weather]).to have_key(:humidity)
      expect(result[:data][:attributes][:current_weather][:humidity]). to be_a Integer

      expect(result[:data][:attributes][:current_weather]).to have_key(:uvi)
      expect(result[:data][:attributes][:current_weather][:uvi]). to be_a Float

      expect(result[:data][:attributes][:current_weather]).to have_key(:visibility)
      expect(result[:data][:attributes][:current_weather][:visibility]). to be_a Float

      expect(result[:data][:attributes][:current_weather]).to have_key(:condition)
      expect(result[:data][:attributes][:current_weather][:condition]). to be_a String

      expect(result[:data][:attributes][:current_weather]).to have_key(:icon)
      expect(result[:data][:attributes][:current_weather][:icon]). to be_a String

      expect(result[:data][:attributes]).to have_key(:daily_weather)
      expect(result[:data][:attributes][:daily_weather]).to be_a Array

      expect(result[:data][:attributes]).to_not have_key(:location)

      expect(result[:data][:attributes][:current_weather]).to_not have_key(:last_updated_epoch)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:temp_c)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:wind_mph)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:wind_kph)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:wind_degree)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:wind_dir)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:pressure_mb)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:pressure_in)
      expect(result[:data][:attributes][:current_weather]).to_not have_key(:precip_in)

      expect(result[:data][:attributes][:daily_weather].length).to eq(5)

      result[:data][:attributes][:daily_weather].each do |day|
        expect(day).to be_a Hash
        
        expect(day).to have_key(:date)
        expect(day[:date]).to be_a String

        expect(day).to have_key(:sunrise)
        expect(day[:sunrise]).to be_a String

        expect(day).to have_key(:sunset)
        expect(day[:sunset]).to be_a String

        expect(day).to have_key(:max_temp)
        expect(day[:max_temp]).to be_a Float

        expect(day).to have_key(:min_temp)
        expect(day[:min_temp]).to be_a Float

        expect(day).to have_key(:visibility)
        expect(day[:visibility]).to be_a Float

        expect(day).to have_key(:condition)
        expect(day[:condition]).to be_a String

        expect(day).to have_key(:icon)
        expect(day[:icon]).to be_a String

        expect(day).to_not have_key(:date_epoch)
        expect(day).to_not have_key(:day)
        expect(day).to_not have_key(:moonset)
        expect(day).to_not have_key(:moonrise)
        expect(day).to_not have_key(:moon_phase)
        expect(day).to_not have_key(:moon_illumination)
        expect(day).to_not have_key(:hour)
      end

      expect(result[:data][:attributes]).to have_key(:hourly_weather)
      expect(result[:data][:attributes][:hourly_weather]).to be_a Array
      expect(result[:data][:attributes][:hourly_weather].length).to eq(24)

      result[:data][:attributes][:hourly_weather].each do |hour|
        expect(hour).to be_a Hash

        expect(hour).to have_key(:time)
        expect(hour[:time]).to be_a String

        expect(hour).to have_key(:temperature)
        expect(hour[:temperature]).to be_a Float

        expect(hour).to have_key(:conditions)
        expect(hour[:conditions]).to be_a String

        expect(hour).to have_key(:icon)
        expect(hour[:icon]).to be_a String

        expect(hour).to_not have_key(:time_epoch)
        expect(hour).to_not have_key(:temp_c)
        expect(hour).to_not have_key(:temp_f)
        expect(hour).to_not have_key(:is_day)
        expect(hour).to_not have_key(:code)
        expect(hour).to_not have_key(:wind_mph)
        expect(hour).to_not have_key(:wind_kph)
        expect(hour).to_not have_key(:wind_degree)
        expect(hour).to_not have_key(:wind_dir)
        expect(hour).to_not have_key(:pressure_in)
        expect(hour).to_not have_key(:pressure_mb)
        expect(hour).to_not have_key(:precip_in)
        expect(hour).to_not have_key(:precip_mm)
        expect(hour).to_not have_key(:snow_cm)
      end
    end
  end

  describe "sad paths" do
    it "must be a real place", :vcr do
      get "/api/v0/forecast?location=wepfwjfwomm"

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: location must be a real place. Try entering location in the format of 'city,co'")
    end

    it "must have location", :vcr do
      get "/api/v0/forecast"

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: location must be present")
    end
  end
end