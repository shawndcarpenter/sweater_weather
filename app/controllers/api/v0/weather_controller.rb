class  Api::V0::WeatherController < ApplicationController
  def forecast
    geo = get_geocoded_location(params[:location])
    
    render json: 
      ForecastSerializer.new(get_forecast(geo.latitude, 
                                          geo.longitude))
  end
  
  private
  
  def get_geocoded_location(location)
    geocoded_location = GeolocationFacade.new(location).geocode
  end

  def get_forecast(lat, lon)
    WeatherFacade.new(lat, lon).forecast
  end
end