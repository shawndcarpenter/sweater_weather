require 'rails_helper'

RSpec.describe "POST to users", type: :request do
  describe "happy paths" do
    it "will post a user", :vcr do
      user_params = {
                  "email": "whatever@example.com",
                  "password": "password",
                  "password_confirmation": "password"
                  }
      
      post "/api/v0/users", params: user_params

      expect(response).to be_successful
      
      expect(response.status).to eq(201)
      result = JSON.parse(response.body, symbolize_names: true)
      # binding.pry             
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a Hash

      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id].to_i).to be_a Integer

      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to be_a String
      expect(result[:data][:type]).to eq("user")

      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]).to be_a Hash

      expect(result[:data][:attributes]).to have_key(:email)
      expect(result[:data][:attributes][:email]).to be_a String

      expect(result[:data][:attributes]).to have_key(:api_key)
      expect(result[:data][:attributes][:api_key]).to be_a String

      expect(result[:data][:attributes]).to_not have_key(:password)
      expect(result[:data][:attributes]).to_not have_key(:password_confirmation)
    end
  end
end