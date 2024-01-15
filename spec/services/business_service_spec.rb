require 'rails_helper'

RSpec.describe BusinessService do 
  it "can return businesses", :vcr do
    business_results = BusinessService.new.get_businesses("pueblo,co", "italian")

    expect(business_results).to be_a Hash
    expect(business_results[:businesses]).to be_a Array

    business_results[:businesses].each do |business|
      expect(business).to have_key(:id)
      expect(business[:id]).to be_a String

      expect(business).to have_key(:name)
      expect(business[:name]).to be_a String

      expect(business).to have_key(:image_url)
      expect(business[:image_url]).to be_a String
    end
  end
end