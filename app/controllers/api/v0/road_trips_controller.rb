class  Api::V0::RoadTripsController < ApplicationController
  def create
    destination_geo = get_geocoded_location(params[:destination])
    user = User.find_by(api_key: params[:api_key])
    # binding.pry
    if user
      get_forecast(destination_geo.latitude, destination_geo.longitude)
      
    else
    end
  end
  
  private
  def get_geocoded_location(location)
    geocoded_location = GeolocationFacade.new(location).geocode
  end

  def get_forecast(lat, lon)
    WeatherFacade.new(lat, lon).forecast
  end
end