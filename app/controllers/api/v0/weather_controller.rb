class  Api::V0::WeatherController < ApplicationController
  def forecast
    # binding.pry
    geocoded_location = GeolocationFacade.new(params[:location]).geocode
    lat = geocoded_location.latitude
    lon = geocoded_location.longitude

  end
end