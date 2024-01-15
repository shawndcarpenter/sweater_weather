require 'rails_helper'

RSpec.describe "munchies", type: :request do
  describe "happy paths" do
    it "will get all parameters for munchies", :vcr do
      
      get "/api/v1/munchies?destination=pueblo,co&food=italian"

      expect(response).to be_successful
      
      expect(response.status).to eq(200)
      result = JSON.parse(response.body, symbolize_names: true)
      binding.pry
      expect(result).to have_key(:data)
      expect(result[:data]).to be_a Hash

      expect(result[:data]).to have_key(:id)
      expect(result[:data][:id]).to eq(nil)

      expect(result[:data]).to have_key(:type)
      expect(result[:data][:type]).to be_a String
      expect(result[:data][:type]).to eq("munchie")

      expect(result[:data]).to have_key(:attributes)
      expect(result[:data][:attributes]). to be_a Hash

      expect(result[:data][:attributes]).to have_key(:destination_city)
      expect(result[:data][:attributes][:destination_city]). to be_a String
      
      expect(result[:data][:attributes]).to have_key(:forecast)
      expect(result[:data][:attributes][:forecast]). to be_a Hash

      expect(result[:data][:attributes][:forecast]).to have_key(:summary)
      expect(result[:data][:attributes][:forecast][:summary]). to be_a String

      expect(result[:data][:attributes][:forecast]).to have_key(:temperature)
      expect(result[:data][:attributes][:forecast][:temperature]). to be_a Float

      expect(result[:data][:attributes]).to have_key(:restaurant)
      expect(result[:data][:attributes][:restaurant]). to be_a Hash

      expect(result[:data][:attributes][:restaurant]).to have_key(:name)
      expect(result[:data][:attributes][:restaurant][:name]). to be_a String

      expect(result[:data][:attributes][:restaurant]).to have_key(:address)
      expect(result[:data][:attributes][:restaurant][:address]). to be_a String

      expect(result[:data][:attributes][:restaurant]).to have_key(:rating)
      expect(result[:data][:attributes][:restaurant][:rating]). to be_a Float

      expect(result[:data][:attributes][:restaurant]).to have_key(:reviews)
      expect(result[:data][:attributes][:restaurant][:reviews]). to be_a Integer
    end
  end
end