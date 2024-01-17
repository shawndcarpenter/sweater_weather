class  Api::V0::ForecastsController < ApplicationController
  def show
    if !params[:location]
      missing_location_response
    elsif valid_location?(params[:location])
      geo = get_geocoded_location(params[:location])

      render json: 
        ForecastSerializer.new(get_forecast(geo.latitude, 
                                            geo.longitude))
    else
      invalid_locations_response
    end
  end
  
  private

  def get_forecast(lat, lon)
    WeatherFacade.new(lat, lon).forecast
  end

  def invalid_locations_response
    render json: ErrorSerializer.new(ErrorMessage.new("Validation failed: location must be a real place. Try entering location in the format of 'city,co'", 422))
    .serialize_json, status: 422
  end

  def missing_location_response
    render json: ErrorSerializer.new(ErrorMessage.new("Validation failed: location must be present", 422))
    .serialize_json, status: 422
  end
end