require 'rails_helper'

RSpec.describe "User login", type: :request do
  describe "happy paths" do
    before :each do
      user_params = {
        "email": "paul@example.com",
        "password": "password",
        "password_confirmation": "password"
        }

      post "/api/v0/users", params: user_params

      @user = User.find_by(email: "paul@example.com")

    end

    it "will login a user", :vcr do
      user_login_params = {
                  "email": "paul@example.com",
                  "password": "password"
                  }
      
      post "/api/v0/sessions", params: user_login_params

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
      expect(result[:data][:attributes][:email]).to eq(@user.email)

      expect(result[:data][:attributes]).to have_key(:api_key)
      expect(result[:data][:attributes][:api_key]).to be_a String
      expect(result[:data][:attributes][:api_key]).to eq(@user.api_key)

      expect(result[:data][:attributes]).to_not have_key(:password)
      expect(result[:data][:attributes]).to_not have_key(:password_confirmation)
    end
  end

  describe "sad paths" do
    before :each do
      user_params = {
        "email": "paul@example.com",
        "password": "password",
        "password_confirmation": "password"
        }

      post "/api/v0/users", params: user_params

      @user = User.find_by(email: "paul@example.com")

    end
  end

  it "must have email and password" do
    post "/api/v0/sessions", params: {}

    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Validation failed: email can't be blank, password can't be blank")
  end

  it "must have email" do
    post "/api/v0/sessions", params: {"password": "password"}

    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Validation failed: email can't be blank")
  end

  it "must have password" do
    post "/api/v0/sessions", params: {"email": "paul@example.com"}

    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Validation failed: password can't be blank")
  end

  it "must have valid email" do
    post "/api/v0/sessions", params: {"email": "not_paul@example.com", "password": "password"}

    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Email or password did not match our records")
  end

  it "must have valid password" do
    post "/api/v0/sessions", params: {"email": "paul@example.com", "password": "not_password"}

    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:errors]).to be_a(Array)
    expect(data[:errors].first[:detail]).to eq("Email or password did not match our records")
  end
end
