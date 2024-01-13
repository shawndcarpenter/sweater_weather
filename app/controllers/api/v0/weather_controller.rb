class  Api::V0::WeatherController < ApplicationController
  def forecast
    geocoded_location = GeolocationFacade.new(params[:location]).geocode
    lat = geocoded_location.latitude
    lon = geocoded_location.longitude

    forecast = WeatherFacade.new(lat, lon).forecast
    # binding.pry

  end
end