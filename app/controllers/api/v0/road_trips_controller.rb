class  Api::V0::RoadTripsController < ApplicationController
  def create
    user = User.find_by(api_key: params[:api_key])

    if user
      road_trip = RoadTripFacade.new(params[:origin], params[:destination]).road_trip

      render json: 
        RoadTripSerializer.new(road_trip), status: 200
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