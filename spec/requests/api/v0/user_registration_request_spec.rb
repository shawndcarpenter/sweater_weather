require 'rails_helper'

RSpec.describe "POST to users", type: :request do
  describe "happy paths" do
    it "will post a user", :vcr do
      
      post "/api/v0/users", params: {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
        }, as: :json

      expect(response).to be_successful
      
      expect(response.status).to eq(201)
      result = JSON.parse(response.body, symbolize_names: true)
           
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

  describe "sad path testing" do
    it "must have matching password and confirmation" do

      post "/api/v0/users", params: {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "not_password"
        }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: Password confirmation doesn't match Password")
    end

    it "must have password and confirmation" do

      post "/api/v0/users", params: {
        "email": "whatever@example.com"
        }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: Password can't be blank, Password can't be blank, Password confirmation can't be blank")
    end

    it "must have password" do

      post "/api/v0/users", params: {
        "email": "whatever@example.com",
        "password_confirmation": "not_password"
        }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: Password can't be blank, Password can't be blank")
    end

    it "must have password confirmation" do

      post "/api/v0/users", params: {
        "email": "whatever@example.com",
        "password": "password"
        }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: Password confirmation can't be blank")
    end

    it "must have email" do
      post "/api/v0/users", params: {
        "password": "password",
        "password_confirmation": "password"
        }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: Email can't be blank")
    end

    it "email must be unique" do

      post "/api/v0/users", params: {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
        }, as: :json
      post "/api/v0/users", params: {
        "email": "whatever@example.com",
        "password": "password",
        "password_confirmation": "password"
        }, as: :json

      expect(response).to_not be_successful
      expect(response.status).to eq(422)

      data = JSON.parse(response.body, symbolize_names: true)

      expect(data[:errors]).to be_a(Array)
      expect(data[:errors].first[:detail]).to eq("Validation failed: Email has already been taken")
    end
  end
end