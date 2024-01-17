class  Api::V0::RoadTripsController < ApplicationController

  def create
    user = User.find_by(api_key: params[:api_key])
    
    if !params[:origin] || !params[:destination]
      missing_parameters_response(params)
    elsif !valid_location?(params[:origin]) || !valid_location?(params[:destination])
      invalid_locations_response
    elsif user && params[:api_key]
      destination_geocode = GeolocationFacade.new(params[:destination]).geocode 
      road_trip = RoadTripFacade.new(params[:origin], params[:destination], destination_geocode).road_trip

      render json: 
        RoadTripSerializer.new(road_trip), status: 201
    else
      not_allowed_response
    end
  end
  
  private

  def invalid_locations_response
    render json: ErrorSerializer.new(ErrorMessage.new("Validation failed: origin and destination must be real places", 422))
    .serialize_json, status: 422
  end

  def valid_location?(location)
    GeolocationFacade.new(location).geocode.class == Geocode
  end

  def missing_parameters_response(params)
    message = []
    if !params[:origin] 
      message << "origin can't be blank"
    end
      
    if !params[:destination]
      message << "destination can't be blank"
    end

    if !params[:api_key]
      message << "api_key can't be blank"
    end

    render json: ErrorSerializer.new(ErrorMessage.new("Validation failed: #{message.join(", ")}", 422))
    .serialize_json, status: 422
  end

  def not_allowed_response
    render json: ErrorSerializer.new(ErrorMessage.new("Unauthorized: please provide a valid api_key", 401))
    .serialize_json, status: 401
  end
end