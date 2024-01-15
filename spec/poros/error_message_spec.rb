require "rails_helper"

RSpec.describe ErrorMessage do
  describe "Forecast Objects", :vcr do
    before :each do
      @error_message = ErrorMessage.new("Validation failed", 422)
    end

    it "exists" do
      expect(@error_message).to be_a ErrorMessage
    end

    it "responds to error_message methods" do
      expect(@error_message).to respond_to(:message)
      expect(@error_message).to respond_to(:status_code)
      expect(@error_message.message).to eq("Validation failed")
      expect(@error_message.status_code).to eq(422)
    end
  end
end