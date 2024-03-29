class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_response

  private
  
  def invalid_response(exception)
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 422))
    .serialize_json, status: 422
  end

  def get_geocoded_location(location)
    geocoded_location = GeolocationFacade.new(location).geocode
  end

  def valid_location?(location)
    GeolocationFacade.new(location).geocode.class == Geocode
  end
end
